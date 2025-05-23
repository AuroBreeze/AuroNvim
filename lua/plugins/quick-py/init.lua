-- ~/.config/nvim/lua/venvfinder/init.lua
local M = {}
local config = {
    venv_names = { ".venv", "venv" },
    python_path = nil,
    auto_activate = true,
}

-- 缓存项目根和 venv 目录
M.cached_root = nil
M.cached_venv_dir = nil

-- 合并用户配置
function M.setup(user_config)
    config = vim.tbl_deep_extend("force", config, user_config or {})
end

-- 向上查找 .venv 或 venv
local function find_local_venv()
    local dir = vim.fn.getcwd()
    while dir and dir ~= '/' do
        for _, name in ipairs(config.venv_names) do
            local cand = dir .. '/' .. name
            if vim.fn.isdirectory(cand) == 1 then
                return dir, cand
            end
        end
        dir = vim.fn.fnamemodify(dir, ':h')
    end
    return nil, nil
end

-- 激活虚拟环境并缓存
function M.activate_venv()
    local cwd = vim.fn.getcwd()
    if M.cached_root == cwd and config.python_path then
        return M.cached_venv_dir
    end
    local root, venv = find_local_venv()
    if not root then
        vim.notify("[venvfinder] 未找到 .venv 或 venv", vim.log.levels.WARN)
        return nil
    end
    venv = venv:gsub('\\', '/'):gsub('/+$', '')
    local pybin = vim.fn.has('win32')==1 and (venv..'/Scripts/python.exe') or (venv..'/bin/python')
    if vim.fn.executable(pybin)==0 then
        vim.notify("[venvfinder] Python 不可执行: "..pybin, vim.log.levels.ERROR)
        return nil
    end
    vim.env.VIRTUAL_ENV = venv
    vim.env.PATH = venv..(vim.fn.has('win32')==1 and '/Scripts;' or '/bin:')..vim.env.PATH
    config.python_path = pybin
    vim.g.python3_host_prog = pybin
    M.cached_root = cwd; M.cached_venv_dir = venv
    vim.notify("[venvfinder] 已激活: "..venv, vim.log.levels.INFO)
    return venv
end

-- 自动命令组
local aug = vim.api.nvim_create_augroup('ActivateVenv', { clear = true })

-- Python 文件激活 venv
vim.api.nvim_create_autocmd({'BufEnter','BufNewFile'}, {
    pattern = '*.py', group = aug,
    callback = M.activate_venv,
})

-- 终端打开时 Source 虚拟环境
vim.api.nvim_create_autocmd('TermOpen', {
    pattern = '*', group = aug,
    callback = function()
        local venv = M.activate_venv()
        local chan = vim.b.terminal_job_id
        if venv and chan then
            if vim.fn.has('win32')==1 then
                vim.fn.chansend(chan, venv..'/Scripts/activate.bat\r')
            else
                vim.fn.chansend(chan, 'source '..venv..'/bin/activate\n')
            end
        end
    end,
})

-- 配置 Pyright LSP
local ok, lspconfig = pcall(require, 'lspconfig')
if ok then
    lspconfig.pyright.setup({
        cmd = { 'pyright-langserver', '--stdio' },
        before_init = function(_, config_)
            M.activate_venv()
            if config.python_path then
                config_.settings = config_.settings or {}
                config_.settings.python = config_.settings.python or { analysis = {} }
                config_.settings.python.analysis.pythonPath = config.python_path
            end
        end,
        settings = {
            python = {
                analysis = {
                    pythonPath = config.python_path
                }
            }
        },
        root_dir = function(fname)
            return M.cached_root or lspconfig.util.root_pattern('.git', 'pyproject.toml', 'setup.py')(fname)
        end,
    })
end

-- RunPython 命令
vim.api.nvim_create_user_command('RunPython', function()
    if not config.python_path then
        vim.notify("[venvfinder] 未激活 venv", vim.log.levels.ERROR)
        return
    end
    local cmd = config.python_path .. ' ' .. vim.fn.shellescape(vim.fn.expand('%:p'))
    local ok2 = pcall(require,'betterterm')
    if ok2 then require('betterterm').exec(cmd) else vim.cmd('!'..cmd) end
end, { desc = 'Run Python in venv' })

-- 初始化配置
M.setup()
return M

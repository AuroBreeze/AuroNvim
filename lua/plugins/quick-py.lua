return {
    "AuroBreeze/quick-py",
    dependencies={
        "ahmedkhalf/project.nvim",
        "nvim-telescope/telescope.nvim",
        "CRAG666/betterTerm.nvim",
        "nvim-lua/plenary.nvim"
    },
    lazy =true,
    event = "VeryLazy",

    config = {
    -- 本地虚拟环境目录名称（按顺序尝试）
    venv_names = { ".venv", "venv" },

    -- Python 解释器路径（留空则自动从虚拟环境推断）
    python_path = nil,

    -- 自定义运行命令（优先于默认运行当前文件）
    -- 可用命令动态设置：:SetRunPythonCmd <command>
    runserver_cmd = nil, -- 例如："python manage.py runserver" / "uvicorn app.main:app --reload"

    -- 本地 venv 查找范围（向上/向下）
    max_up_depth = 2,   -- 向上回溯父目录层数
    max_down_depth = 2, -- 在每层目录内向下递归的最大深度

    -- 打开终端时是否自动注入激活脚本
    -- 也可命令控制：:QuickPyAutoActivate on|off|toggle
    auto_activate_terminal = false,

    -- betterTerm 相关行为（若已安装 CRAG666/betterTerm.nvim）
    betterterm = {
      index = 0,            -- 目标终端编号
      send_delay = 200,     -- 发送命令前的延迟（毫秒）
      focus_on_run = true,  -- 发送命令后是否聚焦终端
      open_if_closed = true -- 目标终端未开启时自动打开
    },

    -- requirements 扫描安装器（Telescope）的搜索配置
    requirements = {
      depth_down = 2,       -- 向下扫描深度（默认示例 2；推荐 6）
      depth_up = 0,         -- 向上回溯层数（0 = 仅当前工作目录）
      excludes = {          -- 排除目录名（逐段匹配）
        '.git', 'node_modules', '.venv', 'venv', '__pycache__', '.mypy_cache',
        '.pytest_cache', '.cache', 'dist', 'build', '.idea', '.vscode', '.tox',
      },
      include_all_txt = true, -- 是否包含所有 *.txt（否则仅匹配 requirements*.txt）
      strategy = 'pip',       -- 安装策略：'pip'（统一 python -m pip）或 'native'（按 env_type 使用原生命令）
    },

    -- 环境检测优先级（按顺序尝试）
    env_detection = { 'local', 'poetry', 'pipenv', 'uv', 'pdm', 'conda' },

    -- Pyright 配置（会在 on_new_config 中注入当前 venv 的 python 路径）
    lsp_config = { typeCheckingMode = "basic" },

    -- 键位映射（可用 :SetPyKeymap <name> <key> 动态修改）
    keymaps = {
      run_python = { "<leader>rp", ":RunPython<CR>", { desc = "Run Python file" } }, -- 一键运行
      set_lsp = { "<leader>rl", ":SetLsp<CR>", { desc = "Set LSP for Python" } }, -- 设置本地LSP
      install_requirements = { "<leader>ri", ":QuickPyInstallReqs<CR>", { desc = "Install from requirements (Telescope)" } }, -- 安装requirements
      toggle_auto_activate = { "<leader>ta", ":QuickPyAutoActivate<CR>", { desc = "Toggle python venv auto activate terminal" } }, -- 自动激活虚拟环境
    },
  }
}
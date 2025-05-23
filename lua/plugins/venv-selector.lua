-- local function get_python_cmd()
--   require('venv-selector').retrieve_from_cache()
--   local venv_path = require('venv-selector').get_active_path()
--   if venv_path then
--     print("Using venv: ".. venv_path)
--     return venv_path
--   else
--     return "python"
--   end
-- end



return {
  'linux-cultist/venv-selector.nvim',
  dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python',
  -- {"CRAG666/code_runner.nvim",
  --   dependencies = { "linux-cultist/venv-selector.nvim"},
  --   opts = {
  --     filetype = {
  --       python = get_python_cmd() .. " -u $fileName"
  --     },
  --     project_path = vim.fn.getcwd(),
  --     before_run = "w", -- 保存文件
  --     focus = false,    -- 不跳转到终端
  --   },
  --   keys = {
  --     { "<leader>rr", "<cmd>RunCode<CR>", desc = "Run Code" }
  --   }}
},

  config = function()
    require('venv-selector').setup {
      -- Your options go here
      name = ".venv",
      auto_refresh = true,
    }
  end,

  event = 'VeryLazy', -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
  keys = {
    -- Keymap to open VenvSelector to pick a venv.
    { '<leader>vs', '<cmd>VenvSelect<cr>' },
    -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
    { '<leader>vc', '<cmd>VenvSelectCached<cr>' },
  },
}

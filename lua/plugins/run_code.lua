-- local function get_python_cmd()
--   require('venv-selector').setup {}
--   local venv_path = require('venv-selector').get_active_path()
--   if venv_path then
--     return venv_path
--   else
--     return "python"
--   end
-- end


return {
    "CRAG666/code_runner.nvim",
    dependencies = { "linux-cultist/venv-selector.nvim"},
    opts = {
      filetype = {
        python = "python" .. " -u $fileName"
      },
      project_path = vim.fn.getcwd(),
      before_run = "w", -- 保存文件
      focus = false,    -- 不跳转到终端
    },
    keys = {
      { "<leader>rr", "<cmd>RunCode<CR>", desc = "Run Code" }
    }
  }
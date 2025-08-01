return {
    "AuroBreeze/quick-py",
    dependencies={
        "ahmedkhalf/project.nvim"
    },
    lazy =true,
    event = "VeryLazy",
    branch = "dev",

    config = {
    venv_names = { ".venv", "venv" },
    python_path = nil,
    runserver_cmd = nil, -- 运行自定义python命令 ，例如django： python manage.py runserver
    lsp_config = {
        typeCheckingMode = "off"
    }, -- 语言服务器配置
    -- 新增键位配置
    keymaps = {
        run_python = { "<leader>rp", ":RunPython<CR>", { desc = "Run Python file" } },
        set_lsp = { "<leader>rl", ":SetLsp<CR>", { desc = "Set LSP for Python" } },
    }
}
}
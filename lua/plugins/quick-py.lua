return {
    "AuroBreeze/quick-py",
    dependencies={
        "ahmedkhalf/project.nvim"
    },
    lazy =true,
    event = "VeryLazy",
    patterns = { "*.py" },
    config = function()
        require("quick-py").setup({})
    end
}
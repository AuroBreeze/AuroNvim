return {
    "AuroBreeze/quick-py",
    dependencies={
        "ahmedkhalf/project.nvim"
    },
    -- lazy =true,
    patterns = { "*.py" },
    config = function()
        require("quick-py").setup({})
    end
}
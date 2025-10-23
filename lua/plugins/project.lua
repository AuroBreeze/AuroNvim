return {
  "ahmedkhalf/project.nvim",
  lazy = true,
  event = "VeryLazy",
  config = function()
    require("project_nvim").setup({
      detection_methods = { "pattern", "lsp" },
      patterns = { ".git", "Makefile", "package.json", ".hg", ".svn", "Makefile" },
    })
    require("telescope").load_extension("projects")
  end,
}

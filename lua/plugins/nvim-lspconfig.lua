return {
  "neovim/nvim-lspconfig",
  lazy = true,
  event = "VeryLazy",
  config = function()
    local lspconfig = require("lspconfig")
    lspconfig.clangd.setup({
      cmd = {
        "E:/engine_software/LLVM/bin/clangd.exe",
        "--query-driver=E:/engine_software/mingw32/bin/*",
        "--all-scopes-completion",
        "--header-insertion=never",
        "--compile-commands-dir=.",
      },
      -- 这里可以继续加 on_attach/capabilities 等
    })
  end,
}
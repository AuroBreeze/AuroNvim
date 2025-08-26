return {
  "neovim/nvim-lspconfig",
  lazy =true,
  event="VeryLazy",
  opts = {
    servers = {
      clangd = {
        mason = false, -- 禁止用 mason 自带的 clangd
        cmd = {
          "C:/Program Files/LLVM/bin/clangd.exe",
          "--query-driver=C:/software/mingw64/bin/*", -- 换成你 g++ 的路径
          "--all-scopes-completion",
          "--header-insertion=never",
          "--compile-commands-dir=.",
        },
      },
    },
  },
}
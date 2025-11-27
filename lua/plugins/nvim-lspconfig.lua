-- 文件路径: ~/.config/nvim/lua/plugins/nvim-lspconfig.lua
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    -- ✅ 在这里 require
    local lspconfig = require("lspconfig")

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    pcall(function()
      capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
    end)

    -- ✅ clangd 配置
    lspconfig.clangd.setup({
      cmd = {
        "D:/engine_software/LLVM/bin/clangd.exe",
        "--query-driver=D:/engine_software/mingw64/bin/gcc.exe",
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed",
        "--header-insertion=never",
      },
      capabilities = capabilities,
      init_options = {
        fallbackFlags = { "-std=c11"},
      },
    })
  end,
}

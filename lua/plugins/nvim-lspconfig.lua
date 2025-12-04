return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local lspconfig = require("lspconfig")

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    pcall(function()
      capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
    end)

    -- ⭐ 这里新增：on_attach 里专门给 LSP 绑定按键
    local on_attach = function(client, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }
      local map = function(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, opts)
      end

      -- Hover 文档
      map("n", "K", vim.lsp.buf.hover)
      -- ⭐ 真正的「跳转到定义」（跨文件）
      map("n", "gd", vim.lsp.buf.definition)
      -- 跳到声明
      map("n", "gD", vim.lsp.buf.declaration)
      -- 跳到实现
      map("n", "gi", vim.lsp.buf.implementation)
      -- 查引用
      map("n", "gr", vim.lsp.buf.references)
    end

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
        fallbackFlags = { "-xc", "-std=c11" },
      },
      on_attach = on_attach,  -- ⭐ 把 on_attach 挂上去
    })
  end,
}

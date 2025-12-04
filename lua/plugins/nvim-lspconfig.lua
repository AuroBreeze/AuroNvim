return {
  "neovim/nvim-lspconfig",
  lazy = true,
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

      map("n", "K", "<cmd>Lspsaga hover_doc<CR>")        -- 漂亮 hover（文档）
      
      map("n", "gp", "<cmd>Lspsaga peek_definition<CR>") -- 预览定义（代码）

      -- ⭐ 真正的「跳转到定义」（跨文件）
      map("n", "gd", "<cmd>Lspsaga finder def<CR>")
      -- 跳到声明
      map("n", "gD", vim.lsp.buf.declaration)
      -- 跳到实现
      map("n", "gi", "<cmd>Lspsaga finder imp<CR>")
      -- 查引用
      map("n", "gr", "<cmd>Lspsaga finder ref<CR>")
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

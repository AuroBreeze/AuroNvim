return {
    "nvimdev/lspsaga.nvim",
    lazy = true,
    event = "VeryLazy",
    config = function()
      require("lspsaga").setup({})
      -- vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
    end,
  }
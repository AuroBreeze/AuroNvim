return {
  {
    "saghen/blink.cmp",
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      { "giuxtaposition/blink-cmp-copilot", dependencies = { "zbirenbaum/copilot.lua" } },
      "zbirenbaum/copilot.lua",
    },

    opts = function(_, opts)
      opts = opts or {}

      -- ✅ 键位映射
      opts.keymap = {
        preset = "default",
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<C-e>"] = { "cancel" },
        ["<C-Space>"] = { "show", "fallback" },
      }

      -- 🎨 外观美化
      opts.appearance = {
        use_nvim_cmp_as_default = true,
        use_icons = true,
        menu = {
          border = "rounded",
          max_height = 15,
          max_width = 60,
        },
      }

      -- ⚙️ Sources
      opts.sources = {
        default = { "copilot", "lsp", "path", "buffer", "snippets" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            kind = "Copilot",
            score_offset = 100,
            async = true,
          },
        },
      }

      -- 🪄 Copilot 初始化
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })

      return opts
    end,
  },
}

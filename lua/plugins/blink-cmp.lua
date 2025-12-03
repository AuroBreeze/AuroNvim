return {
  {
    "saghen/blink.cmp",
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      { "fang2hou/blink-copilot", dependencies = { "zbirenbaum/copilot.lua" } },
      "zbirenbaum/copilot.lua",
    },

    opts = function(_, opts)
      opts = opts or {}

      -- ✅ 禁用自动补全，只手动触发
      opts.completion = {
        auto_complete = false,
      }

      -- ✅ 键位映射
      opts.keymap = {
        preset = "default",
        ["<C-CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<C-e>"] = { "cancel" },
        ["<C-Space>"] = { "show", "fallback" }, -- 手动触发
      }

      -- 🎨 外观
      opts.appearance = {
        use_nvim_cmp_as_default = true,
        menu = {
          border = "rounded",
          max_height = 15,
          max_width = 60,
        },
      }

      -- ⚙️ Sources
      opts.sources = {
        default = { "copilot", "lsp", "path", "buffer", "snippets", "minuet" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            kind = "Copilot",
            score_offset = 100,
            async = true,
          },
          minuet = {
              name = 'minuet',
              module = 'minuet.blink',
              async = true,
              -- Should match minuet.config.request_timeout * 1000,
              -- since minuet.config.request_timeout is in seconds
              timeout_ms = 3000,
              score_offset = 75, -- Gives minuet higher priority among suggestions
            },
        },
      }

      opts.completion = { trigger = { prefetch_on_insert = false } },

      -- 🪄 Copilot 初始化
      require("copilot").setup({
        suggestion = { enabled = false }, -- 禁用内联建议
        panel = { enabled = false },
      })

      return opts
    end,
  },
}

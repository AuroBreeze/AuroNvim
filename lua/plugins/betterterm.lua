return {
  'CRAG666/betterTerm.nvim',
  lazy =true,
  event="VeryLazy",
  keys = {
    {
      mode = { 'n', 't' },
      '<C-/>',
      function()
        require('betterTerm').open()
      end,
      desc = 'Open BetterTerm 0',
    },
    {
      mode = { 'n', 't' },
      '<C-;>',
      function()
        require('betterTerm').open(1)
      end,
      desc = 'Open BetterTerm 1',
    },
    {
      '<leader>ts',
      function()
        require('betterTerm').select()
      end,
      desc = 'Select terminal',
    },
    {
      '<leader>tw',
      function()
        local betterTerm = require('betterTerm')
        -- 打开一个新的终端(例如索引为2的终端)
        betterTerm.open(1)
        -- 延迟发送命令以确保终端已完全初始化
        vim.defer_fn(function()
          betterTerm.send('wsl -d archlinux\r\n')
        end, 300)
      end,
      desc = 'Open ArchLinux WSL Terminal',
    }
  },
  opts = {
    position = 'bot',
    size = 20,
    jump_tab_mapping = "<A-$tab>"
  },
}
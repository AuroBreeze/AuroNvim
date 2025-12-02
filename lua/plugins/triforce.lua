return {
    'gisketch/triforce.nvim',
    dependencies = { 'nvzone/volt' },
    lazy = true,
    event = 'VeryLazy',
    config = function()
        require('triforce').setup({
        -- Optional: Add your configuration here
        keymap = {
            show_profile = '<leader>tp', -- Open profile with <leader>tp
        },
        -- Customize XP rewards (optional)
        xp_rewards = {
        char = 1,   -- XP per character typed
        line = 1,   -- XP per new line
        save = 1,  -- XP per file save
        },
    })
    end,
}
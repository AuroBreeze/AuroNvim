return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = true,
    event = 'VeryLazy',
    config = function()
        local triforce = require('triforce.lualine').components()
        require('lualine').setup({
            sections = {
                lualine_x = {
                triforce.level,
                triforce.achievements,
                triforce.streak,
                triforce.session_time,
                'encoding', 'fileformat', 'filetype'
                },
            }
        })
    end
}
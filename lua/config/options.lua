-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.relativenumber = false
vim.o.guifont = "JetBrainsMonoNL Nerd Font" -- text below applies for VimScript

-- 启用鼠标
vim.opt.mouse:append("a")

-- 系统剪贴板
vim.opt.clipboard:append("unnamedplus")

-- tab设置
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- 禁用自动格式化
vim.g.autoformat = false

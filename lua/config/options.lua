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


-- 让 Neovide 窗口背景透明并启用毛玻璃
if vim.g.neovide then
  -- 主窗口透明度（非模糊）
  vim.g.neovide_opacity = 0.95

  -- 浮动窗口高斯模糊
  vim.g.neovide_floating_blur_amount_x = 4.0
  vim.g.neovide_floating_blur_amount_y = 4.0

  -- （可选）设置背景色混合
  vim.g.neovide_background_color = "#1a1b26" .. string.format("%x", math.floor(255 * 0.8))
end



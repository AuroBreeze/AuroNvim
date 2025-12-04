return {
  "karb94/neoscroll.nvim",
  config = function()
    require("neoscroll").setup({
      easing_function = "linear", -- 加速曲线（可选：linear, quadratic, cubic, sine）
      hide_cursor = true, -- 滚动时隐藏光标
      performance_mode = true, -- 长距离滚动时自动加速
    })
  end,
}



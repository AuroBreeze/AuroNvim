return {
  "AuroBreeze/quick-c",
  dependencies = {
    "ahmedkhalf/project.nvim",
    "CRAG666/betterTerm.nvim"
  },
  lazy = true,
  event = "VeryLazy",
  branch = "dev",
  config = {
  outdir = "source", -- 输出到源码目录；也可改为自定义目录
  toolchain = {
    windows = { c = { "gcc", "cl" }, cpp = { "g++", "cl" } },
    unix = { c = { "gcc", "clang" }, cpp = { "g++", "clang++" } },
  },
  autorun = {
    enabled = false,
    events = { "BufWritePost" },
    filetypes = { "c", "cpp" },
  },
  terminal = {
    open = true,
    height = 12,
  },
  betterterm = {
    enabled = true,
    index = 0,
    send_delay = 200,
    focus_on_run = true,
    open_if_closed = true,
  },
}
}

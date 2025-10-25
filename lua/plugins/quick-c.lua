return {
  "AuroBreeze/quick-c",
  -- 三重懒加载：任一触发即可加载
  lazy = true,
  event = "VeryLazy",
  branch = "dev",
  ft = { "c", "cpp" },
  keys = {
    { "<leader>cqb", desc = "Quick-c: Build" },
    { "<leader>cqr", desc = "Quick-c: Run" },
    { "<leader>cqR", desc = "Quick-c: Build & Run" },
    { "<leader>cqD", desc = "Quick-c: Debug" },
    { "<leader>cqM", desc = "Quick-c: Make targets (Telescope)" },
  },
  cmd = {
    "QuickCBuild", "QuickCRun", "QuickCBR", "QuickCDebug",
    "QuickCMake", "QuickCMakeRun", "QuickCAutoRunToggle",
  },
  config = function()
    require("quick-c").setup({
      -- 可执行文件输出目录：
      --  - "source": 输出在源码同目录
      --  - 自定义路径：如 vim.fn.stdpath("data") .. "/quick-c-bin"
      outdir = "source",
      toolchain = {
        -- 编译器探测优先级（按平台与语言）
        windows = { c = { "gcc", "cl" }, cpp = { "g++", "cl" } },
        unix    = { c = { "gcc", "clang" }, cpp = { "g++", "clang++" } },
      },
      autorun = {
        -- 保存即运行功能（默认关闭）
        enabled = false,
        -- 触发自动运行的事件
        events = { "BufWritePost" },
        -- 仅对这些文件类型生效
        filetypes = { "c", "cpp" },
      },
      terminal = {
        -- 运行时是否自动打开内置终端窗口
        open = true,
        -- 终端窗口高度
        height = 12,
      },
      betterterm = {
        -- 安装了 betterTerm 时优先使用
        enabled = true,
        -- 发送到的终端索引（0 为第一个）
        index = 0,
        -- 发送命令的延时（毫秒）
        send_delay = 200,
        -- 发送命令后是否聚焦终端
        focus_on_run = true,
        -- 终端未打开时是否先打开
        open_if_closed = true,
      },
      make = {
        -- 启用/禁用 make 集成
        enabled = true,
        -- 指定优先使用的 make 程序：
        --   - Windows 可设 "make" 或 "mingw32-make"；未设置时按可执行探测
        prefer = nil,

        prefer_force = true,
        -- 固定工作目录（不设置则由插件根据当前文件自动搜索）
        cwd = nil,
        -- Makefile 搜索策略（未显式设置 cwd 时生效）：
        --   以当前文件所在目录为起点，向上 up 层、向下每层 down 层，跳过 ignore_dirs
        search = { up = 2, down = 3, ignore_dirs = { '.git', 'node_modules', '.cache' } },
        telescope = {
          -- Telescope 选择器标题
          prompt_title = "Quick-c Make Targets",
          -- 是否启用预览（目录选择与目标选择均支持）
          preview = true,
          -- 大文件截断策略（按字节与行数）
          max_preview_bytes = 200 * 1024,
          max_preview_lines = 2000,
          -- 是否为预览 buffer 设置 filetype=make（语法高亮）
          set_filetype = true,
          -- 发送命令到终端时的选择行为：
          --   'auto'  有已打开终端则弹选择器，否则走默认策略
          --   'always'总是弹选择器
          --   'never' 始终走默认策略（betterTerm 优先，失败回退内置）
          choose_terminal = 'auto',
        },
         
        args = {
            prompt = false,
            default = "",
            remember = true,
          },
      },
      keymaps = {
        -- 设为 false 可不注入任何默认键位（你可自行映射命令）
        enabled = true,
        -- 置为 nil 或 '' 可单独禁用某个映射
        build = '<leader>cqb',
        run = '<leader>cqr',
        build_and_run = '<leader>cqR',
        debug = '<leader>cqD',
        -- 注意：键位注入使用 unique=true，不会覆盖你已有的映射；冲突时跳过
        make = '<leader>cqM',
      },
      diagnostics = {
        quickfix = {
          enabled = true,
          open = 'warning',   -- always | error | warning | never
          jump = 'warning',   -- always | error | warning | never
          use_telescope = true,
        },
      },
    })
  end,
}
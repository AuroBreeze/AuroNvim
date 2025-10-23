return {
  "mfussenegger/nvim-dap",
  recommended = true,
  lazy=true,
  desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",

  dependencies = {
    "rcarriga/nvim-dap-ui",
    -- virtual text for the debugger
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },
    {
    -- Ensure C/C++ debugger is installed
    "mason-org/mason.nvim",
    optional = true,
    opts = { ensure_installed = { "codelldb" } },
  }
  },
  opts = function()
    local dap = require("dap")
    -- resolve codelldb path (prefer Mason installation)
    local codelldb_cmd = "codelldb"
    local ok_mason, mason_registry = pcall(require, "mason-registry")
    local uv = vim.loop
    local function path_exists(p)
      local st = uv.fs_stat(p)
      return st and (st.type == "file" or st.type == "link")
    end
    local candidates = {}
    if ok_mason then
      local ok_pkg, pkg = pcall(mason_registry.get_package, "codelldb")
      if ok_pkg and pkg and pkg.is_installed and pkg:is_installed() then
        local install
        if type(pkg.get_install_path) == "function" then
          local ok_ip, ip = pcall(function()
            return pkg:get_install_path()
          end)
          if ok_ip then
            install = ip
          end
        end
        if not install and type(pkg.install_path) == "string" then
          install = pkg.install_path
        end
        if install then
          if vim.fn.has("win32") == 1 then
            table.insert(candidates, install .. "\\extension\\adapter\\codelldb.exe")
            table.insert(candidates, install .. "\\adapter\\codelldb.exe")
          else
            table.insert(candidates, install .. "/extension/adapter/codelldb")
            table.insert(candidates, install .. "/adapter/codelldb")
          end
        end
      end
    end
    local data = vim.fn.stdpath("data")
    if vim.fn.has("win32") == 1 then
      table.insert(candidates, data .. "\\mason\\bin\\codelldb.cmd")
      table.insert(candidates, data .. "\\mason\\bin\\codelldb.exe")
    else
      table.insert(candidates, data .. "/mason/bin/codelldb")
    end
    for _, p in ipairs(candidates) do
      if path_exists(p) or vim.fn.executable(p) == 1 then
        codelldb_cmd = p
        break
      end
    end
    if not dap.adapters["codelldb"] then
      require("dap").adapters["codelldb"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = codelldb_cmd,
          args = {
            "--port",
            "${port}",
          },
        },
      }
    end
    for _, lang in ipairs({ "c", "cpp" }) do
      dap.configurations[lang] = {
        {
          type = "codelldb",
          request = "launch",
          name = "Launch file",
          stopOnEntry = false,
          initCommands = {
            "settings set target.process.thread.step-avoid-libraries true",
          },
          runInTerminal = true,
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
        },
        {
          type = "codelldb",
          request = "attach",
          name = "Attach to process",
          pid = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }
    end
  end,

  -- stylua: ignore
  keys = {
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
    { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
    { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>dj", function() require("dap").down() end, desc = "Down" },
    { "<leader>dk", function() require("dap").up() end, desc = "Up" },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>ds", function() require("dap").session() end, desc = "Session" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
  },

  config = function()
    -- load mason-nvim-dap here, after all adapters have been setup
    if LazyVim.has("mason-nvim-dap.nvim") then
      require("mason-nvim-dap").setup(LazyVim.opts("mason-nvim-dap.nvim"))
    end

    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    for name, sign in pairs(LazyVim.config.icons.dap) do
      sign = type(sign) == "table" and sign or { sign }
      vim.fn.sign_define(
        "Dap" .. name,
        { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
      )
    end
      -- initial cleanup in case other configs already set listeners
      clear_close_listeners()

      -- if something still closes the UI on end, reopen it immediately
      dap.listeners.after.event_terminated["dapui_keep_reopen"] = function()
        dapui.open()
      end
      dap.listeners.after.event_exited["dapui_keep_reopen"] = function()
        dapui.open()
      end
    end
    -- setup dap config by VsCode launch.json file
    -- ensure configurations exist for c/cpp even if opts() didn't run yet
    local function ensure_cfg(lang)
      if not dap.configurations[lang] or vim.tbl_isempty(dap.configurations[lang]) then
        dap.configurations[lang] = {
          {
            type = "codelldb",
            request = "launch",
            name = "Launch file",
            stopOnEntry = false,
            initCommands = {
              "settings set target.process.thread.step-avoid-libraries true",
            },
            program = function()
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
          },
          {
            type = "codelldb",
            request = "attach",
            name = "Attach to process",
            pid = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
        }
      end
    end
    ensure_cfg("c")
    ensure_cfg("cpp")
  end,
}
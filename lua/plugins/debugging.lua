return {
  --[[

    complete debugger setup for neovim using dap-ui and nvim-dap

  ]]--
  -- install nvim-dap
  "mfussenegger/nvim-dap-ui",
  dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
  config = function ()
    -- dap setup and keybindings
    local dap, dapui = require("dap"), require("dapui")
    -- initialise dapui
    dapui.setup()
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
    -- setup JavaScript debugger 
    require("dap").adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        -- path to the debugger 
        args = {
          vim.fn.expand("~/.config/nvim/debuggers/js-debug/src/dapDebugServer.js"),
          "${port}"
        },
      }
    }
    -- debugger configuration
    require("dap").configurations.javascript = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
    }
    -- set keybindings
    vim.keymap.set('n', '<Leader>db', function() dap.toggle_breakpoint() end)
    vim.keymap.set('n', '<Leader>dc', function() dap.continue() end)
  end,
}

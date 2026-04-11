return {
  {
    "mason-org/mason.nvim",
    opts = {},
    config = function()
      require("mason").setup()
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-lspconfig").setup({
        automatic_installation = true,
        -- add language servers here
        ensure_installed = { "lua_ls", "ts_ls", "jdtls", "clangd", "omnisharp" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",

    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup({
        -- Hier listest du deine Server einfach nur auf
        ensure_installed = { "ts_ls", "html", "lua_ls" },
      })

      -- Das ist der moderne "Zaubertrick":
      mason_lspconfig.setup_handlers({
        -- Die Standard-Funktion, die für jeden installierten Server aufgerufen wird
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,

        -- Wenn du für einen speziellen Server extra Settings brauchst (z.B. Lua):
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = { globals = { "vim" } },
              },
            },
          })
        end,
      })
    end,
  }
  -- minimale, sichere Diagnostic-Konfiguration (zeigt inline-Text + Floats)
  vim.diagnostic.config({
    virtual_text = {
      prefix = "●", -- kleines Symbol vor der Nachricht (optional)
      spacing = 2,
    },
    signs = true, -- Errors in der Sign column links
    underline = true, -- unterstreicht fehlerhafte Stellen
    update_in_insert = false, -- keine Live-Diagnostics beim Tippen
    severity_sort = true,
  })

  -- optional: float automatisch beim Verweilen über einer Stelle
  vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
      vim.diagnostic.open_float(nil, { focus = false })
    end,
  })

  -- configure and enable language Servers
  vim.lsp.config("lua_ls", {})
  vim.lsp.enable("lua_ls")
  vim.lsp.config("ts_ls", {})
  vim.lsp.enable("ts_ls")
  vim.lsp.config("jdtls", {})
  vim.lsp.enable("jdtls")
  vim.lsp.config("clangd", {})
  vim.lsp.enable("clangd")
  vim.lsp.config("omnisharp", {})
  vim.lsp.enable("omnisharp")
  -- set keymaps
  vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
  vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
end,
},
}

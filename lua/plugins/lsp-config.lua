return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
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
    end
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      vim.diagnostic.config({
        virtual_text = true, -- Zeigt den Error-Text direkt hinter der Zeile an
        signs = true,        -- Behält das 'E' am Rand bei
        underline = true,    -- Unterstreicht den Fehler im Code
        update_in_insert = false,
        severity_sort = true,
      })
      -- enable and configure language servers
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

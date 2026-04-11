return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.completion.spell,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.formatting.prettierd,
      },
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
  {
    "williamboman/mason-null-ls.nvim",
    dependencies = { "williamboman/mason.nvim", "nvimtools/none-ls.nvim" },
    config = function()
      require("mason-null-ls").setup({
        -- Hier müssen die Namen rein, die Mason benutzt!
        ensure_installed = { "eslint_d", "prettierd", "stylua" },
        automatic_installation = true,
      })
    end,
  },
}

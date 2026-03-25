return {
  {
    "DonJulve/NeoCyberVim",
    lazy =  false,
    priority = 1000,
    config = function()
      require('NeoCyberVim').setup({
        -- NOTE: if your configuration sets vim.o.background in your configuration for Neovim,
        -- the following setting will do nothing, since it'll be overriden.
        transparent = false, -- Boolean: Sets the background to transparent
        italics = {
          comments = true, -- Boolean: Italicizes comments
          keywords = true, -- Boolean: Italicizes keywords
          functions = true, -- Boolean: Italicizes functions
          strings = true, -- Boolean: Italicizes strings
          variables = true, -- Boolean: Italicizes variables
        },
        overrides = {}, -- A dictionary of group names, can be a function returning a dictionary or a table.
      })
      vim.cmd("colorscheme NeoCyberVim")
    end
  }
}

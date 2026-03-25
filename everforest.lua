/* 
return {
  {
    "neanias/everforest-nvim",
    version = false,
    name = "everforest",
    lazy = false,
    priority = 1000,
    config = function()
      require("everforest").setup({
        background = "hard",
        italics = true,
        transparent_background_level = 0,
        ui_contrast = "high",
        dim_inactive_windows = false,
      })
      vim.o.background = "dark"
      vim.cmd("colorscheme everforest")
    end,
  },
}
*/

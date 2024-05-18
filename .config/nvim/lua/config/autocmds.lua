-- Autocmds are automatically loaded on the VeryLazy event
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    require("colorizer").setup()
  end,
})

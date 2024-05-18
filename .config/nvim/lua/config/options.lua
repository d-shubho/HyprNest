-- Add any additional options here
vim.opt.linespace = 3
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.g.autoformat = false --disable autoformat

-- These are for neovide-gui-client
if vim.g.neovide == true then
  vim.api.nvim_set_keymap(
    "n",
    "<C-+>",
    ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>",
    { silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<C-->",
    ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>",
    { silent = true }
  )
  vim.api.nvim_set_keymap("n", "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>", { silent = true })
  vim.g.neovide_transparency = 0.7
  vim.o.guifont = "VictorMono Nerd Font:h14:b" -- text below applies for VimScript
  vim.g.neovide_padding_top = 20
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 10
  vim.g.neovide_padding_left = 10

  vim.g.neovide_floating_blur_amount_x = 3.0
  vim.g.neovide_floating_blur_amount_y = 3.0
end

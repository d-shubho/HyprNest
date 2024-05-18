-- Keymaps are automatically loaded on the VeryLazy event

local keymap = vim.keymap

-- open dashboard
keymap.set("n", "<leader>.", ":Dashboard<Return>", { noremap = true, silent = true, desc = "Open dashboard" })

-- ufo folding
keymap.set("n", "<leader>r", require("ufo").openAllFolds, { noremap = true, silent = true, desc = "open folded line" })
keymap.set("n", "<leader>m", require("ufo").closeAllFolds, { noremap = true, silent = true, desc = "close all folds" })

-- view notifaction with telescope

keymap.set("n", "<leader>N", ":Telescope notify<Return>", { noremap = true, silent = true, desc = "View Notifications" })

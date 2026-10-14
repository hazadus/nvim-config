-- Insert mode keymaps - custom style

-- Shift+<-/-> = jump word left / right
vim.keymap.set("i", "<M-Left>", "<Esc>bi", { noremap = true })
vim.keymap.set("i", "<M-Right>", "<Esc>ea", { noremap = true })

-- Ctrl+d = Delete current word
vim.keymap.set("i", "<C-d>", "<Esc>dawa", { noremap = true })

-- Ctrl+Shift+d = Delete current line
vim.keymap.set("i", "<C-S-d>", "<Esc>dda", { noremap = true })

-- Ctrl+Shift+Down = Copy current line below
vim.keymap.set("i", "<C-S-Down>", "<Esc>Vypa", { noremap = true })

-- Shift+Delete = Delete from cursor to end of line
vim.keymap.set("i", "<S-Del>", "<Esc>Da", { noremap = true })

-- Shift+Up/Down = Move current line up/down
vim.keymap.set("i", "<S-Up>", "<Esc>Vdkkpa", { noremap = true })
vim.keymap.set("i", "<S-Down>", "<Esc>Vdpa", { noremap = true })

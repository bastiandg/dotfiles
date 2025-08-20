-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("", "<F10>", "^r✓ddGp<C-o>")
map("n", "<F4>", 'dd:r!date "+\\#\\# \\%d.\\%m.\\%Y"<CR>A<CR><CR>')
map("n", "<Tab>", ">>")
map("n", "<S-Tab>", "<<")
map("v", "<Tab>", ">gv")
map("v", "<S-Tab>", "<gv")

-- Render Markdown and copy to clipboard
map("v", "^X@sc", ":w !sh -c 'pandoc | xclip -selection c -t text/html'<CR>")

-- Copy to clipboard
map("v", "<C-c>", '"+y')

map("n", ";", ":")
map("n", "j", "gj")
map("n", "k", "gk")

map("v", "^X@sc", ":w !sh -c 'pandoc | xclip -selection c -t text/html'<CR>")

-- Additional escape key mappings
map("i", "<F1>", "<ESC>")
map("n", "<F1>", "<ESC>")
map("v", "<F1>", "<ESC>")

map("n", "Q", "<Nop>")

map("i", "°", "✓")
map("n", "<CR>", "G")
map("n", "<BS>", "gg")

-- Insert mode mappings for moving between windows
map("i", "<C-h>", "<C-\\><C-N><C-w>h")
map("i", "<C-j>", "<C-\\><C-N><C-w>j")
map("i", "<C-k>", "<C-\\><C-N><C-w>k")
map("i", "<C-l>", "<C-\\><C-N><C-w>l")

-- Normal mode mappings for moving between windows
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Command aliases
vim.cmd("command WQ wq")
vim.cmd("command Wq wq")
vim.cmd("command W w")
vim.cmd("command Q q")

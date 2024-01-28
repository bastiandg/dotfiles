local function map(mode, lhs, rhs, opts)
  local options = { noremap=true, silent=true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- YRShow mappings
map('n', '<F3>', ':YRShow<CR>')
map('i', '<F3>', '<ESC>:YRShow<CR>')

-- Tail -f like action
map('n', '<F4>', 'dd:r!date "+\\#\\# \\%d.\\%m.\\%Y"<CR>A<CR><CR>')

-- Preserve commands
map('n', '<F5>', ':call Preserve("%s/\\s\\+$//e")<CR>')
map('n', '<F6>', ':call Preserve("normal gg=G")<CR>')

-- MySpellLang mappings
map('n', '<F7>', ':call MySpellLang()<CR>')
map('i', '<F7>', '<C-o>:call MySpellLang()<CR>')

-- NERDTree toggle
map('', '<F8>', ':NERDTreeToggle<CR>')

-- Custom F10 mapping
map('', '<F10>', '^r✓ddGp<C-o>')

-- Tab mappings
map('n', '<Tab>', '>>')
map('n', '<S-Tab>', '<<')
map('v', '<Tab>', '>gv')
map('v', '<S-Tab>', '<gv')

-- Redo mapping
map('n', 'U', '<C-r>')

-- Insert mode mappings for moving between windows
map('i', '<C-h>', '<C-\\><C-N><C-w>h')
map('i', '<C-j>', '<C-\\><C-N><C-w>j')
map('i', '<C-k>', '<C-\\><C-N><C-w>k')
map('i', '<C-l>', '<C-\\><C-N><C-w>l')

-- Normal mode mappings for moving between windows
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')


-- Other normal mode mappings
map('n', ';', ':')
map('n', 'j', 'gj')
map('n', 'k', 'gk')

-- Render Markdown and copy to clipboard
map('v', '^X@sc', ":w !sh -c 'pandoc | xclip -selection c -t text/html'<CR>")
-- Copy to clipboard
map('v', '<C-c>', '"+y')

-- Additional escape key mappings
map('i', '<F1>', '<ESC>')
map('n', '<F1>', '<ESC>')
map('v', '<F1>', '<ESC>')

-- Disable Q in normal mode
map('n', 'Q', '<Nop>')


-- Command aliases
vim.cmd('command WQ wq')
vim.cmd('command Wq wq')
vim.cmd('command W w')
vim.cmd('command Q q')

-- Terminal mappings
map('n', '<C-t>', ':term<CR>')  -- open
map('t', '<Esc>', '<C-\\><C-n>')                    -- exit

-- Disable arrow keys
map('', '<up>', '<nop>')
map('', '<down>', '<nop>')
map('', '<left>', '<nop>')
map('', '<right>', '<nop>')

map('i', '°', '✓')
map('n', '<CR>', 'G')
map('n', '<BS>', 'gg')

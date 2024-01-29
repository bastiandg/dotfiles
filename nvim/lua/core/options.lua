local opt = vim.opt   -- Set options (global/buffer/windows-scoped)

-- Save undo history
opt.undofile = true

opt.splitright = true       -- Vertical split to the right
opt.splitbelow = true       -- Horizontal split to the bottom
opt.ignorecase = true       -- Ignore case letters when search
opt.smartcase = true        -- Ignore lowercase for the whole pattern

-- disable mouse
opt.mouse = ''
opt.termguicolors = true


opt.hidden = true           -- Enable background buffers
opt.history = 100           -- Remember N lines in history

--opt.clipboard = 'unnamedplus'         -- Copy/paste to system clipboard
opt.number = true           -- Show line number
opt.showmatch = true        -- Highlight matching parenthesis
opt.linebreak = true        -- Wrap on word boundary

opt.incsearch = true

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true        -- Use spaces instead of tabs
opt.shiftwidth = 2          -- Shift 2 spaces when tab
opt.tabstop = 2             -- 1 tab == 2 spaces
opt.smartindent = true      -- Autoindent new lines

opt.autoindent = true       -- always set autoindenting on
opt.copyindent = true       -- always set copyindenting on

opt.list = true             -- list nonprintable characters
opt.listchars = "tab:» ,trail: ,precedes:»,extends:…,eol:¬,nbsp:␣"

opt.cursorline = true
vim.o.scrolloff = 999       -- center cursor

vim.cmd("colorscheme base16-hardcore")

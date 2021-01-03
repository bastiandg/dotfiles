set enc=utf-8
set termguicolors
if exists('&inccommand')
	set inccommand=split
endif

if exists("+undofile")
	set udf
	set undodir=~/.vimundo
endif

set nocompatible " explicitly get out of vi-compatible mode
"set completeopt=menu
set wildmenu " enhanced command-line completion
set shortmess+=c

set splitbelow
set splitright
set background=dark
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"
set history=10000
set showmode
set hlsearch "highlight search results
set number "line numbers
set so=100 "scroll offset
set incsearch
set ignorecase               " Do case insensitive matching
set smartcase                " overwrite ignorecase if pattern contains uppercase characters
set shiftwidth=4             " number of spaces to use for each step of indent
set tabstop=4                " number of spaces a tab counts for
set noexpandtab
set backspace=indent,eol,start " make backspace a more flexible

" ########## text options ##########
set smartindent              " always set smartindenting on
set autoindent               " always set autoindenting on
set copyindent               " always set copyindenting on
set fileformats=unix,dos,mac " support all three, in this order
set nostartofline " leave my cursor where it was
set guicursor= " prevent weird konsole behaviour


set list                 " list nonprintable characters
set listchars+=precedes:<,extends:> " display the following nonprintable characters
if $LANG =~ ".*\.UTF-8$" || $LANG =~ ".*utf8$" || $LANG =~ ".*utf-8$"
	set listchars=tab:»\ ,trail:\ ,precedes:»,extends:…,eol:¬,nbsp:␣
else
	set listchars=tab:>\ ,trail:-
endif

let g:is_bash=1 " Enable here-strings in bash highlighting

" restore cursor position
autocmd BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line("$") |
			\   exe "normal! g`\"" |
			\ endif

silent! colorscheme base16-hardcore
hi Normal ctermbg=Black ctermfg=White guifg=White guibg=Black
hi Search guibg=black guifg=White gui=underline
set guifont=Source\ Code\ Pro\ 14
set cursorline
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"
"underline the current line
hi CursorLine cterm=NONE,underline
au! BufWritePre terragrunt.hcl call terraform#fmt()
"au! BufWritePre *.sh silent call Preserve("%!shfmt -i 2 -ci")

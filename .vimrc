call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-sleuth'
Plug 'ekalinin/Dockerfile.vim'
Plug 'luochen1990/rainbow'
Plug 'plasticboy/vim-markdown'
Plug 'vim-syntastic/syntastic'

" colorschemes
Plug 'tomasr/molokai'
Plug 'lisposter/vim-blackboard'
Plug 'dracula/vim'
call plug#end()

" rainbow parantheses config
let g:rainbow_active = 1
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}'], ['<', '>']]
let g:rainbow_conf = {
\	'operators': '_,\|+\|-\|*\|\/\|!=\|==\||\|:_'
\}

" disable auto markdown folding
let g:vim_markdown_folding_disabled = 1

" highlight indentation levels
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=Black   guifg=White
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#272822 guifg=#F8F8F2

" syntastic
let g:syntastic_python_flake8_args = "--ignore=W191"

if has('nvim')
	let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
endif
set enc=utf-8
set termguicolors

if exists("+undofile")
	set udf
	set undodir=~/.vimundo
endif

function! Preserve(command)
	" Preparation: save last search, and cursor position.
	let _s=@/
	let l = line(".")
	let c = col(".")
	" Do the business:
	execute a:command
	" Clean up: restore previous search history, and cursor position
	let @/=_s
	call cursor(l, c)
endfunction

if has('conceal')
	set cole=2
	let g:tex_conceal= 'adgm'
	set conceallevel=2 concealcursor=i
	"hi Conceal guibg=DarkMagenta guifg=White
	hi Conceal cterm=bold ctermfg=161 ctermbg=0 guibg=White guifg=DarkMagenta
endif

set nocompatible " explicitly get out of vi-compatible mode
set completeopt=menu
set wildmenu " enhanced command-line completion
set background=dark
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"
set history=10000
set showmode
set hlsearch "highlight search results
set number "line numbers
set so=100 "scroll offset
set incsearch

inoremap <c-o> <c-x><c-o>
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
			\ "\<lt>C-n>" :
			\ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
			\ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
			\ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>
inoremap <silent><Down> <C-r>=pumvisible()?"\<lt>C-n>":"\<lt>Down>"<CR>
inoremap <silent><Up> <C-r>=pumvisible()?"\<lt>C-p>":"\<lt>Up>"<CR>

autocmd BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line("$") |
			\   exe "normal! g`\"" |
			\ endif


vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

"Keep search pattern at the center of the screen.
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz

nnoremap <CR> G
nnoremap <BS> gg

"Split Window movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
inoremap jj <ESC>
nnoremap ; :
"movement keys
"nnoremap <up> :tabnew<CR>
"nnoremap <down> <nop>
"nnoremap <left> :tabprevious<CR>
"nnoremap <right> :tabnext<CR>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

"Commenting function with ü
nnoremap ü :call NERDComment(0, "toggle")<cr>
vnoremap <silent> ü :call NERDComment(0, "toggle")<cr>

function! YRRunAfterMaps()
	" Y yanks from cursor to $
	nnoremap Y :<C-U>YRYankCount 'y$'<CR>
endfunction

"additional escape key
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
nnoremap <silent> <F3> :YRShow<cr>
inoremap <silent> <F3> <ESC>:YRShow<cr>
"tail -f like action
nmap <F4> :e<CR>GL:sleep 1<CR><F4>
nmap <F5> :call Preserve("%s/\\s\\+$//e")<CR>
nmap <F6> :call Preserve("normal gg=G")<CR>
map <F7> :call MySpellLang()<CR>
imap <F7> <C-o>:call MySpellLang()<CR>
map <F8> : NERDTreeToggle<CR>
"run current script
map <F9> <ESC>:w<CR>:!%<CR>
nnoremap <Tab> >>
nnoremap <S-Tab> <<
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
nnoremap U <C-r>

:command WQ wq
:command Wq wq
:command W w
:command Q q

cnoreabbrev te tabedit

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

set laststatus=2 " always show the status line
"set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
"              | | | | |  |   |      |  |     |    |
"              | | | | |  |   |      |  |     |    + current
"              | | | | |  |   |      |  |     |       column
"              | | | | |  |   |      |  |     +-- current line
"              | | | | |  |   |      |  +-- current % into file
"              | | | | |  |   |      +-- current syntax in
"              | | | | |  |   |          square brackets
"              | | | | |  |   +-- current fileformat
"              | | | | |  +-- number of lines
"              | | | | +-- preview flag in square brackets
"              | | | +-- help flag in square brackets
"              | | +-- readonly flag in square brackets
"              | +-- rodified flag in square brackets
"              +-- full path to file in the buffer

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi StatColor guibg=#95e454 guifg=black ctermbg=lightgreen ctermfg=black

set list                 " list nonprintable characters
set listchars+=precedes:<,extends:> " display the following nonprintable characters
if $LANG =~ ".*\.UTF-8$" || $LANG =~ ".*utf8$" || $LANG =~ ".*utf-8$"
	set listchars=tab:»\ ,trail:\ ,precedes:»,extends:…,eol:¬,nbsp:␣
else
	set listchars=tab:>\ ,trail:-
endif

if has("gui_running")
	set guifont=Source\ Code\ Pro\ 14
endif

"switch spellcheck languages
let g:myLang = 0
let g:myLangList = [ "nospell", "de_de", "en_us" ]
function! MySpellLang()
	"loop through languages
	let g:myLang = g:myLang + 1
	if g:myLang >= len(g:myLangList) | let g:myLang = 0 | endif
	if g:myLang == 0 | set nospell termguicolors | endif
	if g:myLang == 1 | setlocal spell spelllang=de_de notermguicolors | endif
	if g:myLang == 2 | setlocal spell spelllang=en_us notermguicolors | endif
	echo "language:" g:myLangList[g:myLang]
endf

vnoremap <silent> * :<C-U>
	\let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
	\gvy/<C-R><C-R>=substitute(
	\escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
	\gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
	\let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
	\gvy?<C-R><C-R>=substitute(
	\escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
	\gV:call setreg('"', old_reg, old_regtype)<CR>

colorscheme blackboard
hi Normal ctermbg=Black ctermfg=White guifg=White guibg=Black

set cursorline
"underline the current line
hi CursorLine cterm=NONE,underline

hi StatColor guibg=#95e454 guifg=black ctermbg=lightgreen ctermfg=black
hi Modified guibg=orange guifg=black ctermbg=lightred ctermfg=black

function! MyStatusLine(mode)
	let statusline=""
	if a:mode == 'Enter'
		let statusline.="%#StatColor#"
	endif
	let statusline.="\(%n\)\ %f\ "
	if a:mode == 'Enter'
		let statusline.="%*"
	endif
	let statusline.="%#Modified#%m"
	if a:mode == 'Leave'
		let statusline.="%*%r"
	elseif a:mode == 'Enter'
		let statusline.="%r%*"
	endif
	let statusline .= "[%L][%{&ff}]%y[%p%%][%04l,%04v]"
	return statusline
endfunction

au WinEnter * setlocal statusline=%!MyStatusLine('Enter')
au WinLeave * setlocal statusline=%!MyStatusLine('Leave')
set statusline=%!MyStatusLine('Enter')

function! InsertStatuslineColor(mode)
	if a:mode == 'i'
		hi StatColor guibg=orange ctermbg=lightred
	elseif a:mode == 'r'
		hi StatColor guibg=#e454ba ctermbg=magenta
	elseif a:mode == 'v'
		hi StatColor guibg=#e454ba ctermbg=magenta
	else
		hi StatColor guibg=red ctermbg=red
	endif
endfunction

highlight ExtraWhitespace ctermbg=red guibg=red
augroup WhitespaceMatch
	" Remove ALL autocommands for the WhitespaceMatch group.
	autocmd!
	autocmd BufWinEnter * let w:whitespace_match_number =
				\ matchadd('ExtraWhitespace', '\s\+$')
	autocmd InsertEnter * call s:ToggleWhitespaceMatch('i')
	autocmd InsertLeave * call s:ToggleWhitespaceMatch('n')
augroup END

function! s:ToggleWhitespaceMatch(mode)
	let pattern = (a:mode == 'i') ? '\s\+\%#\@<!$' : '\s\+$'
	if exists('w:whitespace_match_number')
		call matchdelete(w:whitespace_match_number)
		call matchadd('ExtraWhitespace', pattern, 10, w:whitespace_match_number)
	else
		" Something went wrong, try to be graceful.
		let w:whitespace_match_number =  matchadd('ExtraWhitespace', pattern)
	endif
endfunction

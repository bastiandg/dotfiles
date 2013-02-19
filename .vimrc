call pathogen#infect()
syntax on
filetype plugin indent on
set completeopt=menu
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
set wildmenu " enhanced command-line completion
set t_Co=256
set background=dark
colorscheme molokai
"let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
let g:pydiction_location = "$HOME/.vim/dicts/complete-dict"
"let g:pydiction_location = "/home/bg/.vim/dicts/complete-dict"
" SuperTab like snippets behavior.
"imap <TAB> neocomplcache#sources#snippets_complete#expandable() ?
"imap <TAB> neocomplcache#sources#snippets_complete#expandable() ? \<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

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

set cole=2
let g:tex_conceal= 'adgm'
"hi Conceal guibg=DarkMagenta guifg=White
hi Conceal cterm=bold ctermfg=161 ctermbg=0 guibg=White guifg=DarkMagenta

"Keep search pattern at the center of the screen.
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
"inoremap <expr><C-j> pumvisible()? "\<C-n>" : "\<C-j>"
"inoremap <expr><C-k> pumvisible()?  "\<C-p>" : "\<C-k>"

let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
"  Use smartcase.
let g:neocomplcache_enable_smart_case = 1

"let g:solarized_termcolors=256
"colorscheme solarized
let mapleader = ","
let g:mapleader = ","
"colorscheme wombat256mod
set history=10000
set showmode
set hlsearch "highlight search results
set number "line numbers
set so=10 "scroll offset
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
"au Syntax * RainbowParenthesesLoadChevrons

set nocompatible " explicitly get out of vi-compatible mode
inoremap <c-o> <c-x><c-o>
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
\ "\<lt>C-n>" :
\ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
\ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
\ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>
"inoremap <c-space> <c-x><c-o>
inoremap <silent><Down> <C-r>=pumvisible()?"\<lt>C-n>":"\<lt>Down>"<CR>
inoremap <silent><Up> <C-r>=pumvisible()?"\<lt>C-p>":"\<lt>Up>"<CR>

autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif

"nnoremap <up> gk
"nnoremap <down> gj
"inoremap <up> <ESC>gka
"inoremap <down> <ESC>gja
"Show Yankring
"Split Window movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
inoremap jj <ESC>
nnoremap ; :
"movement keys
nnoremap <up> :tabnew<CR>
nnoremap <down> <nop>
nnoremap <left> :tabprevious<CR>
nnoremap <right> :tabnext<CR>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
vnoremap <up> <nop>
vnoremap <down> <nop>
vnoremap <left> <nop>
vnoremap <right> <nop>
nnoremap j gj
nnoremap k gk
"Commenting function with ü
nnoremap ü :call NERDComment(0, "toggle")<cr>
vnoremap <silent> ü :call NERDComment(0, "toggle")<cr>
" Y yanks from cursor to $
"nnoremap Y y$
function! YRRunAfterMaps()
	nnoremap Y :<C-U>YRYankCount 'y$'<CR>
endfunction
"additional escape key
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
"tail -f like action
nnoremap <silent> <F3> :YRShow<cr>
inoremap <silent> <F3> <ESC>:YRShow<cr>
nmap <F4> :e<CR>GL:sleep 1<CR><F4>
nmap <F5> :call Preserve("%s/\\s\\+$//e")<CR>
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
"nnoremap <Space> <leader><leader>
"inoremap ü
"nnoremap O <leader>c<space>
let g:EasyMotion_leader_key = '<Space>'

set ignorecase               " Do case insensitive matching
set smartcase                " overwrite ignorecase if pattern contains uppercase characters
set shiftwidth=4             " number of spaces to use for each step of indent
set tabstop=4                " number of spaces a tab counts for
set backspace=indent,eol,start " make backspace a more flexible

" ########## text options ##########
set smartindent              " always set smartindenting on
set autoindent               " always set autoindenting on
set copyindent               " always set copyindenting on
set fileformats=unix,dos,mac " support all three, in this order
"set nostartofline " leave my cursor where it was
"set number " turn on line numbers
"set numberwidth=5 " We are good up to 99999 lines

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

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi StatColor guibg=#95e454 guifg=black ctermbg=lightgreen ctermfg=black

set list                 " list nonprintable characters
set listchars+=precedes:<,extends:> " display the following nonprintable characters
if $LANG =~ ".*\.UTF-8$" || $LANG =~ ".*utf8$" || $LANG =~ ".*utf-8$"
	set listchars=tab:»\ ,trail:\ ,precedes:»,extends:…,eol:¬
else
	set listchars=tab:>\ ,trail:-
endif

set cursorline
"underline the current line
hi CursorLine cterm=NONE,underline

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


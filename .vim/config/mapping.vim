inoremap <c-o> <c-x><c-o>
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
			\ "\<lt>C-n>" :
			\ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
			\ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
			\ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>
inoremap <silent><Down> <C-r>=pumvisible()?"\<lt>C-n>":"\<lt>Down>"<CR>
inoremap <silent><Up> <C-r>=pumvisible()?"\<lt>C-p>":"\<lt>Up>"<CR>

"Keep search pattern at the center of the screen.
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz

nnoremap <CR> G
nnoremap <BS> gg

"Split Window movement
inoremap <S-h> <C-\><C-N><C-w>h
inoremap <S-j> <C-\><C-N><C-w>j
inoremap <S-k> <C-\><C-N><C-w>k
inoremap <S-l> <C-\><C-N><C-w>l
nnoremap <S-h> <C-w>h
nnoremap <S-j> <C-w>j
nnoremap <S-k> <C-w>k
nnoremap <S-l> <C-w>l
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

if has('nvim')
	tnoremap <Esc> <C-\><C-n>
	tnoremap <S-h> <C-\><C-N><C-w>h
	tnoremap <S-j> <C-\><C-N><C-w>j
	tnoremap <S-k> <C-\><C-N><C-w>k
	tnoremap <S-l> <C-\><C-N><C-w>l
endif

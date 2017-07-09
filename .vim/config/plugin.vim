call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-sleuth'
Plug 'ekalinin/Dockerfile.vim'
Plug 'luochen1990/rainbow'
Plug 'plasticboy/vim-markdown'
Plug 'vim-syntastic/syntastic'
Plug 'terryma/vim-expand-region'
Plug 'vim-scripts/YankRing.vim'

" colorschemes
Plug 'tomasr/molokai'
Plug 'lisposter/vim-blackboard'
Plug 'dracula/vim'
Plug 'cseelus/vim-colors-lucid'
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

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

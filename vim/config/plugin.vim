call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-sleuth'
Plug 'luochen1990/rainbow'
Plug 'vim-syntastic/syntastic'
Plug 'terryma/vim-expand-region'
Plug 'vim-scripts/YankRing.vim'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" Language plugins
Plug 'ekalinin/Dockerfile.vim'
Plug 'hashivim/vim-vagrant'
Plug 'rodjek/vim-puppet'
Plug 'plasticboy/vim-markdown'

" completion
Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-jedi'
Plug 'Shougo/neco-syntax'

" colorschemes
Plug 'tomasr/molokai'
Plug 'junegunn/seoul256.vim'
call plug#end()

" rainbow parantheses config
let g:rainbow_active = 1
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}'], ['<', '>']]
let g:rainbow_conf = {
\	'operators': '_,\|+\|-\|*\|\/\|!=\|==\||\|:_'
\}

" disable auto markdown folding
let g:vim_markdown_folding_disabled = 1
" disable auto markdown folding
let g:vim_markdown_conceal = 0

" highlight indentation levels
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=Black   guifg=White
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guifg=#82848d guibg=#0c1021

" syntastic
let g:syntastic_python_flake8_args = "--ignore=W191"

" expand region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" airline powerline symbols
let g:airline_powerline_fonts = 1

" deoplete
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" activate limelight with goyo
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

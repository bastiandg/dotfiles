call plug#begin('~/.vim/plugged')
Plug 'leafgarland/typescript-vim'
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
Plug 'junegunn/fzf', { 'dir': '~/.fzf'}
Plug 'junegunn/fzf.vim'

" Language plugins
Plug 'ekalinin/Dockerfile.vim'
Plug 'hashivim/vim-vagrant'
Plug 'rodjek/vim-puppet'
Plug 'plasticboy/vim-markdown'
Plug 'hashivim/vim-terraform'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" completion
Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-jedi'
Plug 'Shougo/neco-syntax'
Plug 'zchee/deoplete-go', { 'do': 'make'}

" colorschemes
Plug 'tomasr/molokai'
Plug 'junegunn/seoul256.vim'
call plug#end()

" vim-terraform
" format on save
let g:terraform_fmt_on_save=1

" override default indentation
let g:terraform_align=1

" rainbow parantheses config
let g:rainbow_active = 1
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}'], ['<', '>']]
let g:rainbow_conf = {'operators': '_,\|+\|-\|*\|&&\|;\|!==\|!=\|===\|==\||\|:_'}
"autocmd Filetype go let g:rainbow_conf = {'operators': '_,\|+\|-\|*\|!=\|==\||\|:_'}

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
let g:syntastic_markdown_mdl_args = "-r ~MD033,~MD013"

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

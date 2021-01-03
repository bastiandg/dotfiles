call plug#begin('~/.vim/plugged')
Plug 'leafgarland/typescript-vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-sleuth'
Plug 'luochen1990/rainbow'
"Plug 'vim-syntastic/syntastic'
Plug 'terryma/vim-expand-region'
Plug 'vim-scripts/YankRing.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf'}
Plug 'junegunn/fzf.vim'
Plug 'ntpeters/vim-better-whitespace'

" Language plugins
Plug 'ekalinin/Dockerfile.vim'
Plug 'hashivim/vim-vagrant'
Plug 'rodjek/vim-puppet'
Plug 'plasticboy/vim-markdown'
Plug 'hashivim/vim-terraform'
Plug 'juliosueiras/vim-terraform-completion'
"Plug 'fatih/vim-go'

" completion
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
"Plug 'Shougo/deoplete.nvim'
"Plug 'zchee/deoplete-jedi'
"Plug 'Shougo/neco-syntax'
"Plug 'zchee/deoplete-go', { 'do': 'make'}

" colorschemes
"Plug 'junegunn/seoul256.vim'
"Plug 'chriskempson/base16-vim'

" git
Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()

let g:yankring_replace_n_nkey = ''

" vim-terraform
" format on save
let g:terraform_fmt_on_save=1

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

" fzf
" https://github.com/junegunn/fzf.vim/pull/707
let $FZF_PREVIEW_COMMAND = 'batcat --color=always -pp {} || cat {}'

" syntastic

let g:syntastic_python_checkers = ['flake8', 'python']
let g:syntastic_python_flake8_args = "--ignore=W191 --max-line-length=150"
let g:syntastic_markdown_mdl_args = "-r ~MD033,~MD013,~MD029"
let g:syntastic_dockerfile_checkers = ['hadolint']
let g:syntastic_yaml_checkers = ['yamllint']
let g:syntastic_yaml_yamllint_args = "-d \"{extends: default, rules: {line-length: {max: 120}}}\""
let g:syntastic_filetype_map = { "Dockerfile": "dockerfile" }

" expand region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" airline powerline symbols
let g:airline_powerline_fonts = 1

" airline_themes
let g:airline_theme='base16_pop'

" deoplete
"let g:deoplete#enable_at_startup = 1
"inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" activate limelight with goyo
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

autocmd BufRead,BufNewFile *.hcl set filetype=terraform
"autocmd vimenter * NERDTree
let NERDTreeMinimalUI = 1
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

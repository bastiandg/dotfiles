lua <<EOF
require'lspconfig'.terraformls.setup{}
require'lspconfig'.pyls.setup{}
require'lspconfig'.gopls.setup{on_attach=require'completion'.on_attach}

local lspconfig = require('lspconfig')
local shfmt = {formatCommand = "shfmt -ci -s -i 2", formatStdin = true}
local shellcheck = {
  lintCommand = "shellcheck -f gcc -x",
  lintFormats = {
    "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m",
  },
}

lspconfig.efm.setup {
  init_options = {documentFormatting = true},
  filetypes = {"sh"},
  settings = {
    rootMarkers = {".git/"},
    languages = {
      sh = {shfmt, shellcheck}},
  },
}
EOF

autocmd BufEnter * lua require'completion'.on_attach()
autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 1000)
autocmd BufWritePre *.sh lua vim.lsp.buf.formatting_sync(nil, 1000)
autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000)

set completeopt=menuone,noinsert,noselect
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"local shfmt = require('lsp.formatters.sh')
"local shellcheck = require('lsp.formatters.shellcheck')

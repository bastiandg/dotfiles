lua <<EOF
require'lspconfig'.pyls.setup{cmd={"podman", "run", "-i", "--rm", "pyls", "pyls"}, on_attach=require'completion'.on_attach}
require'lspconfig'.gopls.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.bashls.setup{cmd={"go", "run", "/home/bastian/git/bago-ls/main.go"}, on_attach=require'completion'.on_attach}
EOF

"require'lspconfig'.bashls.setup{cmd={"tee", "--append", "/home/bastian/lsp.log"}, on_attach=require'completion'.on_attach}
"require'lspconfig'.bashls.setup{cmd={"podman", "run", "-i", "bashls", "bash-language-server", "start"}, on_attach=require'completion'.on_attach}

autocmd BufEnter * lua require'completion'.on_attach()
autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 1000)
"autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000)

set completeopt=menuone,noinsert,noselect
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

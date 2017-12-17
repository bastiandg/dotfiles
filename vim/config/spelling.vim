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

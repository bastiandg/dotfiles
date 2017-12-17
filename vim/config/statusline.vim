set laststatus=2 " always show the status line
au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi StatColor guibg=#95e454 guifg=black ctermbg=lightgreen ctermfg=black
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


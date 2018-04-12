" Install non-existing plugins.
augroup plugininstallation
	autocmd VimEnter *
		\ if exists('g:loaded_plug') && len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) |
			\ PlugInstall --sync |
			\ quitall |
		\ endif
augroup end

" Toggle relative numbers in Insert/Normal mode.
augroup togglerelativelinenumbers
	autocmd!
	autocmd InsertEnter,BufLeave,WinLeave,FocusLost *
		\ if &l:number && empty(&buftype) |
			\ setlocal norelativenumber |
		\ endif
	autocmd InsertLeave,BufEnter,WinEnter,FocusGained *
		\ if &l:number && empty(&buftype) |
			\ setlocal relativenumber |
		\ endif
augroup end

" Local command-line window settings.
augroup commandlinewindowsettings
	autocmd!
	autocmd CmdwinEnter *
		\ setlocal signcolumn=no nonumber norelativenumber |
		\ startinsert
augroup end

" Save the current buffer after any changes.
augroup savebuffer
	autocmd!
	autocmd InsertLeave,TextChanged * nested
		\ if empty(&buftype) && !empty(bufname('')) |
			\ silent! update |
		\ endif
	autocmd FocusGained,BufEnter,CursorHold * silent! checktime
augroup end

" Start insert mode and disable line numbers in terminal buffer.
augroup terminalsettings
	autocmd!
	if has('nvim')
		autocmd TermOpen * setlocal nonumber norelativenumber
		autocmd TermOpen * startinsert
	endif
augroup end

" Set current working directory project root.
augroup setprojectroot
	autocmd!
	autocmd VimEnter,BufEnter * call kutsan#autocmds#setprojectroot()
augroup end

" Jump to last known position and center buffer around cursor.
augroup jumplastknownposition
	autocmd!
	autocmd BufWinEnter ?* call kutsan#autocmds#jumplastknownposition()
augroup end

" Remove trailing whitespace characters.
augroup trimtrailingspaces
	autocmd!
	autocmd BufWritePre * call kutsan#autocmds#trimtrailingspaces()
augroup end

" Open file explorer if argument list contains at least one directory.
augroup openfileexplorer
	autocmd!
	autocmd VimEnter * call kutsan#autocmds#openfileexplorer()
augroup end

" Create directory path if it's not exist.
augroup makemissingdirectory
	autocmd!
	autocmd BufWritePre * call kutsan#autocmds#makemissingdirectory(expand('<afile>:p:h'), v:cmdbang)
augroup end

" Launch table of contents to the left as vertical pane for manual pages.
augroup manshowtoc
	autocmd!
	if has('nvim')
		autocmd FileType man call kutsan#autocmds#showtoc()
	endif
augroup end

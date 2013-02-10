set nocompatible
filetype off
"
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
"
set tabstop=4
set shiftwidth=4
set expandtab
"
"" let Vundle manage Vundle
"" required!
Bundle 'gmarik/vundle'
"
"" The bundles you install will be listed here
"
filetype plugin indent on
"Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
"Bundle 'tpop/vim-fugitive'
"Bundle 'scrooloose/nerdtree'
"Bundle 'klen/python-mode'
"
"" The rest of your config follows here
"
"" Mappings
"" F1
"" F2 - toggles NERDTree
"map <F2> :NERDTreeToggle<CR>
"" F3
"" F4
"" F5
"" F6
"" F7
"" F8
"" F9
"" F10
"" F11
"" F12 - installs new bundles
map <F12> :BundleInstall<CR>
"
"" toggles whitespace display, and sets the chars to show
"nmap <leader>l :set list!
"set listchars=tab:»\ ,eol:¬
"
"" Python Mode
"let g:pymode_rope = 1
"let g:pymode_doc = 1
"let g:pymode_doc_key = 'K'
"let g:pymode_lint = 1
"let g:pymode_lint_checker = "pyflakes,pep8"
"let g:pymode_lint_write = 1
"let g:pymode_virtualenv = 1
"let g:pymode_breakpoint = 1
"let g:pymode_breakpoint_key = '<leader>b'
"let g:pymode_syntax = 1
"let g:pymode_syntax_all = 1
"let g:pymode_syntax_indent_errors = g:pymode_syntax_all
"let g:pymode_syntax_space_errors = g:pymode_syntax_all
"let g:pymode_folding = 0
"
"" Powerline setup
"set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
"set laststatus=2
"
""       Other Stuff
"	
"" line length highlight
"augroup vimrc_autocmds
"    autocmd!
"    " highlight characters past column 120
"    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Orange
"    autocmd FileType python match Excess /\%120v.*/
"    autocmd FileType python set nowrap
"augroup END
"
"" automatically change window's cwd to file's dir
"" set autochdir
"
"if has ('gui_running')
"    highlight Pmenu guibg=#cccccc gui=bold
"endif
"

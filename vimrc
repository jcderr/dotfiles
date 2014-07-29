set nocompatible
filetype off

set clipboard=unnamed

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
set backspace=indent,eol,start

syntax on
set mouse=a
set history=500
"set spell!
"color solarized
set tabpagemax=15
set showmode
set cursorline
set nu              " set line numbers on
set showmatch       " shows matching brackets, etc
set incsearch
set hlsearch
set whichwrap=b,s,h,l,<,>,[,]
set scrolljump=5
set scrolloff=3
set foldenable!

" formatting
set nowrap
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set pastetoggle=<F11>   " sane indentation on paste, tends to be insane
autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
    " remove trailing whitespace & ^M chars

" set md files to be interp as markdown
au BufNewFile,BufRead *.md set filetype=markdown

" other stuff
let mapleader = ','
nnoremap ; :
    " ; works like : for commands
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>l<C-W>_
map <C-H> <C-W>h<C-W>_
    " easier window movement

nnoremap j gj
nnoremap k gk
    " wrapped lines goes down/up to next row

nmap <silent> <leader>/ :nohlsearch<CR>
    " clears search highlight

vnoremap < <gv
vnoremap > >gv
    " visual shifting

if has('cmdline_info')
    set ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
    set showcmd
endif

"let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" The bundles you install will be listed here

filetype plugin indent on
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdtree'
Bundle 'klen/python-mode'
"Bundle 'Townk/vim-autoclose'
Bundle 'Raimondi/delimitMate'
Bundle 'hallettj/jslint.vim'
Bundle 'tsaleh/vim-supertab'
Bundle 'tpope/vim-surround'
Bundle 'altercation/vim-colors-solarized'
Bundle 'vim-scripts/vim-json-bundle'
Bundle 'tpope/vim-markdown'
"Bundle 'jcderr/vim-jekyll'
""undle 'Valloric/YouCompleteMe'
Bundle 'markcornick/vim-vagrant'
Bundle 'vim-ruby/vim-ruby'
" The rest of your config follows here

" Mappings
" F1
" F2 - toggles NERDTree
map <F2> :NERDTreeToggle<CR>
" F3
" F4
" F5
" F6
" F7
" F8
" F9
" F10
" F11
" F12 - installs new bundles
map <F12> :BundleInstall<CR>

" toggles whitespace display, and sets the chars to show
nmap <leader>l :set list!
" set listchars=tab:»\ ,eol:¬

" Python Mode
let g:pymode_rope = 1
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'
let g:pymode_lint = 1
" let g:pymode_lint_checker = "pyflakes,pep8"
let g:pymode_lint_write = 1
let g:pymode_virtualenv = 1
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
let g:pymode_folding = 0

" Powerline setup
" set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set laststatus=2

"       Other Stuff
	
" line length highlight
augroup vimrc_autocmds
    autocmd!
    " highlight characters past column 120
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Orange
    autocmd FileType python match Excess /\%120v.*/
    autocmd FileType python set nowrap
augroup END

" automatically change window's cwd to file's dir
" set autochdir

if has ('gui_running')
    highlight Pmenu guibg=#cccccc gui=bold
endif

" omnicomplete settings
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

if v:version >= 730
    set backup
    set undofile
    set undolevels=500
    set undoreload=1000
    au BufWinLeave * silent! mkview " makes vim save view states
    au BufWinEnter * silent! loadview " makes vim load saved view states
endif

func! WordProcessorMode() 
    setlocal formatoptions=1 
    setlocal noexpandtab 
    map j gj 
    map k gk
    setlocal spell spelllang=en_us 
    set thesaurus+=/Users/sbrown/.vim/thesaurus/mthesaur.txt
    set complete+=s
    set formatprg=par
    setlocal wrap 
    setlocal linebreak 
endfu 

com!            WP      call    WordProcessorMode()

nnoremap <C-P> :Pub

let g:pymode_rope_lookup_project = 0

set encoding=utf-8

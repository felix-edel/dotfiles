set nocompatible

filetype off

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" Other plugins
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'klen/python-mode'
Plugin 'davidhalter/jedi-vim'
Plugin 'w0rp/ale'
Plugin 'timothycrosley/isort'
Plugin 'taglist.vim'
Plugin 'psf/black'

" Color schemes
Plugin 'nanotech/jellybeans.vim'
Plugin 'junegunn/seoul256.vim'
Plugin 'w0ng/vim-hybrid'
Plugin 'joshdick/onedark.vim'
" Activate powerline
Bundle 'Lokaltog/powerline' , {'rtp': 'powerline/bindings/vim/'}

"Bundle 'spolu/dwm.vim'

call vundle#end()

" Set directory for swp files
" For Unix and Win32, if a directory ends in two path separators '//' or '\\',
" the swap file name will be built from the complete path to the file with all
" path separators substituted to percent '%' signs. This will ensure file name
" uniqueness in the preserve directory.
set directory=$HOME/.vim/swapfiles//

filetype plugin indent on  " Load file type plugins and indentation

autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2 expandtab

autocmd FileType python nnoremap <LocalLeader>i :!isort %<CR><CR>

" Security
set modelines=0

" Tabs/spaces
set tabstop=4  " Tab equals four spaces
set shiftwidth=4  " Text indent for > and < operations
set softtabstop=4  " Use four spaces for tab in insert mode
set expandtab  " Use spaces instead of tabs

" Basic options
set encoding=utf-8
set scrolloff=3  " Lines from when to scroll before upper/lower view is reached
set autoindent  " Copy indentation from previous line
set showmode  " Show current mode on the last line
set showcmd  " Display incomplete commands
set hidden
set wildmenu " Shell like file name completion
set wildmode=list:longest,full
set visualbell
set cursorline  " Highlight current line
set ttyfast  " Faster redrawing; Improves smoothness
set lazyredraw  " Only redraw when necessary
set ruler  " Show line and column in status line
set backspace=indent,eol,start  " Allow backspacing over everything in insert mode
set number  " Show line numbers
" set relativenumber  " Show line numbers relative to current line
set colorcolumn=80  " Show a color column at 80 chars

" Useful for powerline
set laststatus=2  " Always show status line
set showtabline=2  " Always show the tabline, even if there is only one tab
set noshowmode  " Hide the default mode text (e.g. -- INSERT -- below he statusline)

" Activate spell checking
" setlocal spell spelllang=en_us

" GUI geometry
set background=dark
let g:hybrid_custom_term_colors = 1
"let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
colorscheme hybrid
"colorscheme onedark

" Change cursor shape in different modes
" https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)

if has ("gui_running")
    syntax enable
    set lines=40 columns=94  " Window size
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
      set guifont=Fira\ Code
      set macligatures
    else
      set guifont=Fira\ Code
    endif
    set guioptions-=m  " No menu bar
    set guioptions-=T  " No tool bar
    set guioptions= " No gui
    highlight SpellBad term=underline gui=undercurl guisp=Orange
else
    syntax on
endif
"
" Commands
let mapleader = ","

" Searching
nnoremap / /\v
vnoremap / /\v
set ignorecase  " Case insensitive search
set smartcase  " Case sensitive search if there is a uppercase letter
set incsearch  " Find next match as we type
set showmatch
set hlsearch  " Highlight all matches
nnoremap <leader><space> :nohlsearch<cr>
set gdefault
" Clear the last search by searching for empty string
let @/ = ""

" Moving
nnoremap <tab> %
vnoremap <tab> %
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" Move Windows with Alt+arrow
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" Pasting from system clipboard
nnoremap <leader>p "+p
vnoremap <leader>p "+p

" Pasting from system clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y

" Switching between buffers
nnoremap <C-N> :bnext<CR>
nnoremap <C-B> :bprev<CR>

" Easier split navigations
" https://thoughtbot.com/blog/vim-splits-move-faster-and-more-naturally
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" More natural split opening
set splitbelow " Open new vertical splits below rather than above
set splitright " Open new horizontal splits right rathern than left

" German quotes
"imap <leader>p „
"imap <leader>q “

" Line handling
set wrap  " Wrap lines
set linebreak  " Wrap at word boundary
set textwidth=79
set formatoptions=qrnl

" Add syntax highlighting for wsgi files
au BufNewFile,BufRead *.wsgi set filetype=python

" CtrlP exclude Python PYC files
set wildignore+=*.pyc
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/]\.(git|tox)$|node_modules$',
    \ 'file': '\v\.DS_Store$',
    \ }

" Nerdtree
map <leader>t :NERDTreeToggle<CR>
nnoremap <silent> <F7> :NERDTreeToggle<CR>

" Taglist customization
let Tlist_Use_Right_Window = 1  " Open taglist in right window instead of left
let Tlist_GainFocus_On_ToggleOpen = 1  " Focus the taglist window when opened
let Tlist_Close_On_Select = 1  " Close the taglist window when a tag was selected
nnoremap <silent> <F8> :TlistToggle<CR>

" Local leader
let maplocalleader = "\\"

" Python whitespace errors
let python_space_errors = 1

" Python mode
let g:pymode_rope = 0

let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

let g:pymode_lint = 0
let g:pymode_lint_checker = 'pyflakes,pep8'
let g:pymode_lint_write = 1

let g:pymode_virtualenv = 1

let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_error = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

let g:pymode_folding = 0

let g:pymode_python = 'python3'
" TODO This always brings up 'no module named black' when starting vim
" let g:black_virtualenv = '~/.local/pipx/venvs/black'
" Automatically run black on save
autocmd BufWritePre *.py execute ':Black'

" ****
" * Terminal Settings
" ****
"if &term =~ 'xterm-256color' || &term =~ 'screen-256color'
"  set t_Co=256
"  set t_Sf=[3%p1%dm
"  set t_Sb=[4%p1%dm
"else
"  set t_Co=16
"  set t_Sf=[3%p1%dm
"  set t_Sb=[4%p1%dm
"  set t_kb=^V<BS>  "this fixs the backspace key
"  fixdel
"endif
"
"if &term =~ 'screen' || &term =~ 'screen-256color'
"  exe "set title titlestring=vim:%t"
"  exe "set title t_ts=\<ESC>k t_fs=\<ESC>\\"
"  exe "set ttymouse=xterm2"
"endif

" Vim does not hijack terminal background color
autocmd VimLeave * :set term=vt100

" ****
" * User Interface 
" ****

" Do not emulate vi's limitations
set nocompatible

" Space toggels folds
nnoremap <space> za

" Enable syntax highlighting if we have color support
if has('syntax') && (&t_Co > 2)
  syntax enable
  colorscheme macvim

  " Highlight whitespace errors
  au Syntax * syn match Error /\s\+$/ | syn match Error /^\s\+$/

  " Code foldin
  set foldmethod=syntax

endif

" highlight right edge of page
set textwidth=80
set colorcolumn=+1
highlight ColorColumn cterm=NONE guibg=#F1F5FA ctermbg=lightgrey

" highlight current line
highlight CursorLine cterm=NONE ctermbg=195 guibg=#CCFFFF
" hi foo cterm=kj
" only highlight if in current buffer
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END


" Keep 50 lines of command line history
set history=50

" Show the line and column number all the time
set ruler

" Set the status bar to 2 lines
set laststatus=2
"set statusline=%{GitBranch()}\ %t
"set statusline+=%{SyntasticStatuslineFlag()}

" Show commands as you're typing them
set showcmd

" Set scroll offset
set scrolloff=3

" have command-line completion <Tab> (for filenames, help topics, option names)
" first list the available options and complete the longest common part, then
" have further <Tab>s cycle through the possibilities:
set wildmode=list:longest,full

" Remove all short messages
set shortmess=

" show matching set of parentheses as they are typed:
set showmatch

" have the mouse enabled:
"set mouse=a "All Times
"set mouse=nv "Normal w/ Visual
"set mouse=cv "Command & Visual
"set mouse=n "Normal (command only)

" don't have files trying to override this .vimrc:
"set nomodeline

" Turn on line numbers
set number
if (version >= 700)
  set numberwidth=5
endif

" backpace
" indent : Allow backspacing over autointends
" eol : Allow backspacing over linefeeds
" start : Allow backspacing over start of insert
set backspace=indent,eol

" enable filetype detection:
filetype on
set encoding=utf8

" This returns you to the position that you left the file
" It checks to make sure that is still a valid line before
" trying to take the cussor there.
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" Set vim spell check file
" set spellfile=/sys/usr/share/vim/vim72/spell/en.utf-8.spl

" Enable spell-checking for commit messages
" autocmd BufNewFile,BufReadPost COMMIT_EDITMSG set spell

" Omni complete
if (version >= 700)
  set omnifunc=syntaxcomplete#Complete
endif

" ****
" * Text Formatting - General
" ****
set shiftwidth=2
if (version >= 704)
  set softtabstop=-1 " -1 to copy the value of shiftwidth
else
  set softtabstop=2
endif
set tabstop=8

" replace tabs with spaces
set expandtab

" this has to do with Auto indenting
filetype indent on
set autoindent
set smartindent

" ****
" * Search and Replace *
" ****

" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

" show the `best match so far' as search strings are typed:
set incsearch

" allows you to quickly find the corresponding opening/closing tag - key (%)
filetype plugin on

" hit this button before pasting code so text is inserted literally
set pastetoggle=<F9>

" highlight search matches
set hlsearch

" set charictors to be displayed with list
set listchars=tab:»\ ,trail:·,eol:¶,nbsp:·

" show non-printable chars by default
"set list

" ****
" * Graphical VIM settings
" ****

" Remove menu bar
set guioptions-=m

" Remove toolbar
set guioptions-=T

" Remove right side scrollbar
set guioptions-=r

" ****
" * vimdiff
" ****

" Ignore whitespace in diff
set diffopt+=iwhite

" disable syntax highlighting
if &diff
  syntax off
endif

" ****
" * Add custom function
" ****

" run #!
function! CheckForShebang()
   if (match( getline(1) , '^\#!') == 0)
     !./%
   elseif (&ft == 'php')
     !php ./%
   elseif (&ft == 'javascript')
     !node ./%
   elseif (&ft == 'python')
     !python ./%
   else
     echo "Could not excute script."
   end

endfunction
map <F5> :call CheckForShebang()<CR>


" Set permissions correctly on file that contain Shebang
au BufWritePost * if getline(1) =~ "^#!" | if getline(1) =~ "/bin/" | execute "silent !chmod u+x <afile>" | endif | endif

" ****
" * Plugins
" ****
" * Load pathogen plugins
execute pathogen#infect()

" * git gutter
let g:gitgutter_diff_args = '-w'
hi GitGutterAdd  ctermfg=green ctermbg=grey
hi GitGutterChange ctermfg=yellow ctermbg=grey
hi GitGutterDelete ctermfg=red ctermbg=grey
hi GitGutterChangeDelete ctermfg=blue ctermbg=grey

let g:gitgutter_sign_added = '+ '
let g:gitgutter_sign_modified = '~ '
let g:gitgutter_sign_removed = '- '
let g:gitgutter_sign_modified_removed = '~+'

" * NERDTree
let NERDTreeIgnore = ['\.pyc$']
let NERDTreeShowBookmarks=1
let NERDTreeDirArrows=1
map <F2> :NERDTreeToggle \| :silent NERDTreeMirror<cr>


" * syntastic
let g:syntastic_check_on_open=1
"let g:syntastic_enable_signs=1

" Auto open an close :Errors windows
"let g:syntastic_auto_loc_list=1 ' Auto Open and Close
let g:syntastic_auto_loc_list = 2 " Auto Close on no errors

" Set default hieght of :Errors window
let g:syntastic_loc_list_height=5

" Make linemarks nicer
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

" * Powerline
" load powerline
set runtimepath+=/usr/local/lib/python2.7/site-packages/powerline/bindings/vim

" * vim-list-char-toggle
" List Toggle command (show non-printable chars)
map <F10> :call ToggleList()<CR>

" powerline settings
set noshowmode
if has("gui_macvim")
  set guifont=Menlo\ For\ Powerline
  set antialias
endif

" Fix exscape lag
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif


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

  " Highlight whitespace errors
  au Syntax * syn match Error /\s\+$/ | syn match Error /^\s\+$/

  " Code foldin
  set foldmethod=syntax

endif

" highlight right edge of page
set colorcolumn=80
"highlight ColorColumn guibg=#F1F5FA guifg=black ctermbg=lightgrey ctermfg=black

" highlihgt current line
set cursorline

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
set mouse=nv "Normal w/ Visual
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
set tabstop=2

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
   elseif (match( getline(1) , '^<?php') == 0)
       !php ./%
   else
       echo "Could not excute script."
   end

endfunction
map <F5> :call CheckForShebang()<CR>

" List Toggle command (show non-printable chars)
let g:toggle_list = 1
function! ToggleList()
    if exists("g:toggle_list")
        if !exists("b:toggle_list_state")
            let b:toggle_list_state = &list ? 1 : 0
        endif
        let b:toggle_list_state = (b:toggle_list_state + 1) % 3
        if b:toggle_list_state == 0
            set nolist
            echo "nolist"
        elseif b:toggle_list_state == 1
            set list
            if (version >= 700)
                set listchars=tab:»\ ,trail:·,nbsp:·
            else
                set listchars=tab:»\ ,trail:·
            endif
            echo "list"
        elseif b:toggle_list_state == 2
            set list
            if (version >= 700)
                set listchars=tab:»\ ,trail:·,eol:¶,nbsp:·
            else
                set listchars=tab:»\ ,trail:·,eol:¶
            endif
            echo "more list"
        endif
    else
        set list!
    endif
endfunction
map <F10> :call ToggleList()<CR>
silent call ToggleList() " Turn it on

" Set permissions correctly on file that contain Shebang
au BufWritePost * if getline(1) =~ "^#!" | if getline(1) =~ "/bin/" | execute "silent !chmod u+x <afile>" | endif | endif

" ****
" * Plugins
" ****
" * Load pathogen plugins
execute pathogen#infect()

" * NERDTree

if has("gui_macvim")
  map <D-j> :NERDTreeToggle<cr>
else
  map <F3> :NERDTreeToggle<cr>
endif

" * syntastic
let g:syntastic_check_on_open=1
"let g:syntastic_enable_signs=1

" Auto open an close :Errors windows
let g:syntastic_auto_loc_list=1

" Set default hieght of :Errors window
let g:syntastic_loc_list_height=5

" * Powerline
" load powerline
set runtimepath+=/usr/local/lib/python2.7/site-packages/powerline/bindings/vim

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


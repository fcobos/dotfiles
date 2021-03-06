if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
  set fileencodings=ucs-bom,utf-8,latin1
endif

set nocompatible " Use Vim defaults (much better!)
filetype plugin indent on
set bs=indent,eol,start " allow backspacing over everything in insert mode
set ai " always set autoindenting on
set smartindent
set clipboard^=unnamed,unnamedplus
"set scrolloff=1
"set sj=-50
set display+=lastline
set sidescrolloff=5
set autoread
set incsearch
"set backup " keep a backup file
set viminfo='20,\"50 " read/write a .viminfo file, don't store more than 50 lines of registers
set history=50 " keep 50 lines of command line history
set ruler " show the cursor position all the time

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup fedora
  autocmd!
  " In text files, always limit the width of text to 78 characters
  " autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/run/media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

if has("cscope") && filereadable("/usr/bin/cscope")
  set csprg=/usr/bin/cscope
  set csto=0
  set cst
  set nocsverb
  " add any database in current directory
  if filereadable("cscope.out")
    cs add $PWD/cscope.out
  " else add database pointed to by environment
  elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
  endif
  set csverb
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype plugin on

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"

" airline config
set laststatus=2
let g:airline_left_sep = ' '
let g:airline_left_alt_sep = '|'
let g:airline_right_sep = ' '
let g:airline_right_alt_sep = '|'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#right_sep = ' '
let g:airline#extensions#tabline#right_alt_sep = '|'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
if &term=~'linux'
  let g:airline_powerline_fonts = 0
endif

" disable autocommenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" enable line numbers
set number
"set relativenumber

set nowrap

set ttyfast
set lazyredraw
syntax sync minlines=256
set synmaxcol=200

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
  set t_Co=16
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" centered cursor
":nnoremap j jzz
":nnoremap k kzz
if &t_Co >= 256 || has('gui_running')
  " set Vim-specific sequences for RGB colors
  " this should fix colors in truecolor terminals
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

set background=light
let g:one_allow_italics = 1
colorscheme one

" rainbow parentheses
"autocmd VimEnter * RainbowParentheses
"let g:rainbow#max_level = 4
"let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
" List of colors that you do not want. ANSI code or #RRGGBB
"let g:rainbow#blacklist = [7, 8, 15, 18, 19, 20, 21, '#3e4451']

" this is needed for termite and tilix
autocmd VimEnter * redrawstatus!

" hightlight current line
set cursorline

" column indicator
set colorcolumn=80

" use cache folder for .netrwhist
let g:netrw_home=$XDG_CACHE_HOME.'/vim'

" mutt config
au BufRead /tmp/mutt-* set tw=72

" different cursor shapes depending on the mode.
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[0 q"

" enable mouse
if has('mouse')
  set mouse=a
endif

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible
 
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" vvv Plugins go here vvv
Plugin 'airblade/vim-gitgutter'
Plugin 'easymotion/vim-easymotion'
Plugin 'flazz/vim-colorschemes'
Plugin 'itspriddle/vim-shellcheck'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'machakann/vim-highlightedyank'
Plugin 'preservim/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'wincent/scalpel'
" ^^^ Plugins go here ^^^

call vundle#end()
filetype plugin indent on

" Enable syntax highlighting
syntax on
 
"------------------------------------------------------------
" Must have options {{{1
"
" These are highly recommended options.
 
" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden
 
" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window as mentioned above, and/or either of the following options:
" set confirm
" set autowriteall
 
" Better command-line completion
set wildmenu
 
" Show partial commands in the last line of the screen
set showcmd
 
" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch
 
" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline
 
 
"------------------------------------------------------------
" Usability options {{{1
"
" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.
 
" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
 
" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
 
" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent
 
" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline
 
" Display the cursor position on the last line of the screen or in the status
" line of a window
" set ruler
 
" Always display the status line, even if only one window is displayed
set laststatus=2
 
" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm
 
" Use visual bell instead of beeping when doing something wrong
set visualbell
 
" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=
 
" Enable use of the mouse for all modes
" set mouse=a
 
" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
" set cmdheight=2
 
" Display line numbers on the left
set number
 
" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200
 
" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>
 
 
"------------------------------------------------------------
" Indentation options {{{1
"
" Indentation settings according to personal preference.
 
" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
set softtabstop=4
set expandtab
 
" Indentation settings for using hard tabs for indent. Display tabs as
" four characters wide.
"set shiftwidth=4
"set tabstop=4
 
 
"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings
 
" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
nnoremap Y y$
 
" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

"------------------------------------------------------------
" Git commit messages
au FileType gitcommit setlocal tw=72

" CtrlP plugin
set runtimepath^=~/.vim/bundle/ctrlp.vim

" Powerline
" Linux
" let g:powerline_pycmd="py3"
set rtp+=$HOME/.local/lib/python3.7/site-packages/powerline/bindings/vim/
" Mac
" set rtp+=$HOME/Library/Python/3.7/lib/python/site-packages/powerline/bindings/vim/

" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256
" colours)
set t_Co=256

" Use the system clipboard by default (note: vim --version should list
" +clipboard
" set clipboard=unnamedplus

"-------------------------------------------------
"[TR]
" Use silent! to not report errors.
" The only reason I have this here is s.t. in my automated dotfiles setup
" we don't hang on an error if Vundle (and the color schemes) aren't yet
" installed but we are running the Vundle install at this very moment
" (using vim +Pluginstall +qall)
" colorscheme gruvbox
" colorscheme tender
" colorscheme hybrid
" colorscheme OceanicNext
silent! colorscheme molokai
silent! colorscheme gruvbox
let g:airline_powerline_fonts = 1
let g:airline_theme='bubblegum'

" Nicer redo
nnoremap U :redo<CR>
 

let mapleader = " "
" Note: temporarily always source vimrc so I can do some quick testing
nnoremap <silent> <leader>w :w<CR>:source ~/.vimrc<CR>
nnoremap <silent> <leader>q :q<CR>
nnoremap <silent> <leader>Q :qa<CR>
nnoremap <leader>rcr :source ~/.vimrc<CR>
nnoremap <leader>rce :tabedit ~/.vimrc<CR>
nnoremap <silent> <leader><CR> :nohlsearch<CR>

nnoremap <silent> <leader>t :NERDTreeToggle<CR>

" Helpers for tmux
nnoremap <leader>rcte :tabedit ~/.tmux.conf<CR>

"FZF config
nnoremap <silent> <C-p> :Files<CR>
" Call FZF so you can still enter a directory to search
nnoremap <leader>f :FZF 
nnoremap <leader>p :Buffers<CR>
nnoremap <leader>r :Rg<CR>

" vim-highlightedyank config
let g:highlightedyank_highlight_duration = 100

"NerdCommenter config - <leader>c<space> is comment toggle.
let g:NERDCreateDefaultMappings = 1

" Disable default airline extensions for a cleaner status bar
:let g:airline_extensions = []


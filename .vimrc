" Plugin manager for VIM
call pathogen#infect()
call pathogen#incubate()
call pathogen#helptags()
filetype plugin indent on

" My config
syntax on
setlocal number
set mouse=a
set expandtab
set tabstop=2
set shiftwidth=2
set hid
set smarttab
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Ruby gem file syntax
autocmd BufNewFile,BufRead Gemfile set filetype=ruby

" Close the current buffer
map <leader>bd :Bclose<cr>

map j gj
map k gk

" Fix for powerline
set laststatus=2
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

" Smart Searching
:set incsearch
:set ignorecase
:set smartcase
:set hlsearch
:nmap \q :nohlsearch<CR> " Clear the search hightlight

" CtrlP Settings
:let g:ctrlp_map = '<Leader>t'
:let g:ctrlp_match_window_bottom = 0
:let g:ctrlp_match_window_reversed = 0
:let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
:let g:ctrlp_working_path_mode = 0
:let g:ctrlp_dotfiles = 0
:let g:ctrlp_switch_buffer = 0

" My Key mappings
:nmap \l :setlocal number!<CR>
:nmap \p :set paste!<CR>
:nmap ; :CtrlPBuffer<CR>
:nmap \e :NERDTreeToggle<CR>

" Add full colour support
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
  set t_Co=256
endif

" Theming
set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"
colorscheme solarized

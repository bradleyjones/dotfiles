" .vimrc Bradley Jones

" Plugins ------------------------------------------------------------------{{{
" Install vim-plug if we don't already have it
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree' " File Browser
Plug 'Xuyuanp/nerdtree-git-plugin' " Git plugin for nerdtree
Plug 'scrooloose/nerdcommenter' " \ci toggle code comments
Plug 'tpope/vim-surround' " quickly add '' or () to code
Plug 'alvan/vim-closetag' " auto close html tags
Plug 'Raimondi/delimitMate' " insert mode auto-complete for (), '', etc.
Plug 'tpope/vim-fugitive' " git wrapper for vim
Plug 'altercation/vim-colors-solarized' " Solarized colour theme
Plug 'scrooloose/syntastic' " Syntax checker
Plug 'tpope/vim-repeat' " Make some plugins repeatable
Plug 'tmhedberg/SimpylFold' " Improve folding for python code
Plug 'junegunn/vim-easy-align' " Align text/tables,variables, etc
Plug 'reedes/vim-pencil' " Makes writing prose better in vim
Plug 'ctrlpvim/ctrlp.vim' " CtrlP Fuzzy file & buffer menu
Plug 'vimwiki/vimwiki' " vimwiki organise notes & todo lists, export to HTML
Plug 'mattn/calendar-vim' " Calendar
Plug 'rizzatti/dash.vim' " Dash integration
Plug 'vim-airline/vim-airline' " Vim airline - status bar
Plug 'vim-airline/vim-airline-themes'
"Plug 'edkolev/tmuxline.vim'
Plug 'yggdroot/indentLine' " Show indentation
Plug 'airblade/vim-gitgutter' " Show git status in sidebar
Plug 'majutsushi/tagbar' " Display tags in a window
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } " Golang
Plug 'roxma/vim-hug-neovim-rpc'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim' " Autocompletion
  Plug 'roxma/nvim-yarp'
endif
Plug 'zchee/deoplete-go' " Autocomplete for go
Plug 'tpope/vim-obsession' " Vim store sessions (used with tmux-resurrect)
Plug 'severin-lemaignan/vim-minimap' " Sublime like minimap
Plug 'sheerun/vim-polyglot' " ALL THE LANGUAGES!
Plug 'christoomey/vim-tmux-navigator' " Common split navigation between vim & tmux (ctrl + hjlk)

filetype plugin indent on
call plug#end()

" Plugin Configs -----------------------------------------------------------{{{
" Syntastic config
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


" CtrlP Settings
let g:ctrlp_map = '<C-p>'
let g:ctrlp_match_window_bottom = 1
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 0

" Airline config
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='simple'
let g:airline#extensions#tabline#formatter = 'unique_tail'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = '¬'
let g:airline_symbols.readonly = '⌀'
let g:airline_symbols.linenr = 'Ξ'
let g:airline_symbols.whitespace = ''
let g:airline_symbols.maxlinenr = ''

" Indent line config
let g:indentLine_char = '⎸'

" Completion
let g:deoplete#enable_at_startup = 1
set completeopt-=preview " Hide the preview

" Tagbar config
let g:tagbar_sort = 0
let g:tagbar_autofocus = 1

" GitGutter
set updatetime=100

" NERDTree
"let NERDTreeQuitOnOpen = 1
"let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" vimwiki
"let g:vimwiki_url_maxsave=0
" }}}
" }}}
" General Settings ---------------------------------------------------------{{{

set nocompatible
syntax on

set number
set relativenumber

if has("mouse")
  set mouse=a
  set mousehide
  if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
  endif"
endif
set expandtab
set tabstop=2
set shiftwidth=2
set hid
set smarttab
set wrap "Wrap lines
set list
set listchars=tab:>-,trail:~,extends:>,precedes:<
set backspace=indent,eol,start
set colorcolumn=80
filetype plugin indent on
set encoding=utf-8

set clipboard+=unnamedplus

iabbrev me@ jones.bradley@me.com

" Smart Searching
:set incsearch
:set ignorecase
:set smartcase
:set hlsearch

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Terminal
:tnoremap <Esc> <C-\><C-n>

" }}}
" Key Mappings -------------------------------------------------------------{{{
map j gj
map k gk
" provide hjkl movements in Insert mode via the <Alt> modifier key
inoremap <C-h> <C-o>h
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-l> <C-o>l

" extra map for ESC key while using iPad Pro Smart Keyboard
map § <esc>
imap § <esc>

nmap <leader>l :set number!<CR>
nmap <leader>L :set relativenumber!<CR>
nmap <leader>p :set paste!<CR>
nmap <leader>e :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFind<CR>
nmap <leader>t :TagbarToggle<CR>
nmap <leader>r :source ~/.vimrc<CR>:echo "Reloaded vimrc!"<CR>
nmap <leader>q :nohlsearch<CR> " Clear the search hightlight
nmap <silent> <leader>d <Plug>DashSearch " Dash search
nmap <C-h> :bprevious<CR>
nmap <C-l> :bNext<CR>

nmap <C-b> :CtrlPBuffer<CR>

" }}}
" Colours & Theming ------------------------------------------------------- {{{

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
silent! colorscheme solarized

" }}}
" Language/File type specific config -------------------------------------- {{{

" VIM {{{
augroup ft_vim
    au!
    au FileType vim setlocal foldmethod=marker
    au FileType vim nnoremap <leader>fm i" <esc>73a-<esc>a {{{<cr>}}}<esc>3hxkR
augroup END
" }}}
" Python {{{
augroup ft_python
    au!
    au FileType python setlocal foldmethod=expr foldexpr=SimpylFold(v:lnum)
    au FileType python setlocal tw=79
augroup END
" }}}
" Golang {{{
augroup ft_go
    au!
    au FileType go set nolist
    au FileType go setlocal tw=160
    au FileType go setlocal colorcolumn=159
augroup END
" }}}
" Yaml {{{
augroup ft_yaml
    au!
    au FileType yaml setlocal tw=9000
    au FileType yml setlocal tw=9000
augroup END
" }}}
" Writ ing Prose (blogs, commits, etc.) {{{
augroup pencil
  autocmd!
  "autocmd FileType markdown,mkd,md call pencil#init({'wrap': 'soft'})
  autocmd FileType md call pencil#init({'wrap': 'hard'})
  "autocmd FileType text,txt        call pencil#init({'wrap': 'hard'})
  autocmd FileType mail            call pencil#init({'wrap': 'hard'})
  au FileType md setlocal spell spelllang=en_gb
augroup END
" }}}
" VimWiki Specific {{{
let g:vimwiki_folding='list'
au BufRead,BufNewFile *.wiki set filetype=vimwiki
:autocmd FileType vimwiki map n :VimwikiMakeDiaryNote
function! ToggleCalendar()
  execute ":Calendar"
  if exists("g:calendar_open")
    if g:calendar_open == 1
      execute "q"
      unlet g:calendar_open
    else
      g:calendar_open = 1
    end
  else
    let g:calendar_open = 1
  end
endfunction
:autocmd FileType vimwiki map c :call ToggleCalendar()
" }}}

" }}}
" Folding ----------------------------------------------------------------- {{{
" Stolen from Steve Losh - https://bitbucket.org/sjl/dotfiles/

set foldlevelstart=0

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" Make zO recursively open whatever fold we're in, even if it's partially open.
nnoremap zO zczO

" "Focus" the current line.  Basically:
"
" 1. Close all folds.
" 2. Open just the folds containing the current line.
" 3. Move the line to a little bit (15 lines) above the center of the screen.
" 4. Pulse the cursor line.  My eyes are bad.
"
" This mapping wipes out the z mark, which I never use.
"
" I use :sus for the rare times I want to actually background Vim.
nnoremap <c-z> mzzMzvzz15<c-e>`z:Pulse<cr>

function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()
" }}}

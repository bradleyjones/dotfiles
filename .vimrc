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
"Plug 'scrooloose/syntastic' " Syntax checker
Plug 'tpope/vim-repeat' " Make some plugins repeatable
Plug 'tmhedberg/SimpylFold' " Improve folding for python code
Plug 'junegunn/vim-easy-align' " Align text/tables,variables, etc
Plug 'reedes/vim-pencil' " Makes writing prose better in vim
"Plug 'ctrlpvim/ctrlp.vim' " CtrlP Fuzzy file & buffer menu
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
"if has('nvim')
  "Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"else
  "Plug 'Shougo/deoplete.nvim' " Autocompletion
  "Plug 'roxma/nvim-yarp'
"endif
"Plug 'zchee/deoplete-go' " Autocomplete for go
Plug 'tpope/vim-obsession' " Vim store sessions (used with tmux-resurrect)
Plug 'severin-lemaignan/vim-minimap' " Sublime like minimap
Plug 'sheerun/vim-polyglot' " ALL THE LANGUAGES!
Plug 'christoomey/vim-tmux-navigator' " Common split navigation between vim & tmux (ctrl + hjlk)
Plug 'neoclide/coc.nvim', {'branch': 'release'} " code completion
Plug 'pearofducks/ansible-vim' " Ansible
Plug 'tommcdo/vim-lion' " Align \'s at the end of lines

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
Plug 'github/copilot.vim'

filetype plugin indent on
call plug#end()

" Plugin Configs -----------------------------------------------------------{{{
"
" FZF Config
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

map <C-f> :GFiles<CR>
nnoremap <C-f> :GFiles<CR>
map <C-g> :RG<CR>
map <C-b> :Buffers<CR>
nnoremap <leader>g :GFiles<CR>
nnoremap <leader>t :Tags<CR>
nnoremap <leader>m :Marks<CR>

let g:fzf_tags_command = 'ctags -R'
" Border color
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
let $FZF_DEFAULT_COMMAND="rg --files --hidden"


" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)


" Get text in files with Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--disabled', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  let spec = fzf#vim#with_preview(spec, 'right', 'ctrl-/')
  call fzf#vim#grep(initial_command, 1, spec, a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Git grep
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,

" vimgo
let g:go_code_completion_enabled = 1
let g:go_fmt_experimental = 1
let go_diagnostics_enabled = 1

" Coc config
" if hidden is not set, TextEdit might fail.
set hidden

let g:lion_squeeze_spaces = 1

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=1

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


" Syntastic config
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0


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

let g:airline#extensions#coc#enabled = 1

" Completion
"let g:deoplete#enable_at_startup = 1
"set completeopt-=preview " Hide the preview

" Tagbar config
let g:tagbar_sort = 0
let g:tagbar_autofocus = 1

let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
  \ }

" GitGutter
set updatetime=100

" NERDTree
"let NERDTreeQuitOnOpen = 1
"let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" vimwiki
"let g:vimwiki_url_maxsave=0
"let g:vimwiki_listsyms = '✗○◐●✓'
let g:vimwiki_listsyms = ' ○◐●✓'
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

"nmap <C-b> :CtrlPBuffer<CR>

"Terminal specific
tnoremap <Esc> <C-\><C-n>
autocmd BufWinEnter,WinEnter,BufEnter,TermOpen * if &buftype == 'terminal' | :startinsert | endif

"Close buffer
nmap <leader>c :bd<CR>

" Golang
nmap <leader>gr :split <bar> terminal go run %<CR>
nmap <leader>gt :GoTest<CR>
nmap <leader>gb :split <bar> terminal go build && zsh<CR>
nmap <leader>gl :split <bar> lcd %:p:h <bar> terminal pwd && golangci-lint run<CR> " Running golint on whole folder
nmap <leader>glf :split <bar> lcd %:p:h <bar> terminal pwd && golangci-lint run %<CR>  " Running golint on single file

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
colorscheme solarized

" }}}
" Folding ----------------------------------------------------------------- {{{
" Stolen from Steve Losh - https://bitbucket.org/sjl/dotfiles/

set foldlevelstart=0

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" Make zO recursively open whatever fold we're in, even if it's partially open.
nnoremap zz zczO
nnoremap zA zczA

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
nnoremap <c-z> mzzMzvzz15<c-e>`z<cr>

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
    au FileType go setlocal foldmethod=syntax
    au FileType go setlocal foldnestmax=1
    au FileType go setlocal nofoldenable
    au FileType go set tw=160
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
let g:vimwiki_list = [{'path': '~/Nextcloud/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_folding='expr:quick'
au BufRead,BufNewFile *.md set filetype=vimwiki
au BufRead,BufNewFile *.md highlight Folded ctermbg=None cterm=None guifg=None guibg=None ctermfg=None
au BufRead,BufNewFile *.md highlight LineNr ctermbg=None ctermfg=None
au BufRead,BufNewFile *.md highlight SignColumn ctermbg=None
" :autocmd FileType vimwiki map n :VimwikiMakeDiaryNote
function! ToggleCalendar()
  execute ":Calendar"
  if exists("g:calendar_open")
    if g:calendar_open == 1
      execute "q"
j     unlet g:calendar_open
    else
      g:calendar_open = 1
    end
  else
    let g:calendar_open = 1
  end
endfunction
:autocmd FileType vimwiki map c :call ToggleCalendar()
" }}}
" Json {{{
augroup ft_json
    au!
    au FileType json setlocal tw=9000 foldmethod=syntax
augroup END
" }}}

" }}}

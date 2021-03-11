" Install VimPlug automatically
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup VimPlug
    autocmd!
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup END
endif
" Let's load plugins
call plug#begin('~/.vim/plugged')
Plug 'dense-analysis/ale'
Plug 'fcpg/vim-altscreen'
Plug 'Guergeiro/clean-path.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'habamax/vim-select'
Plug 'habamax/vim-select-more'
Plug 'itchyny/vim-gitbranch'
Plug 'itchyny/lightline.vim'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/fern-hijack.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'mattn/emmet-vim'
Plug 'maximbaz/lightline-ale'
Plug 'mbbill/undotree'
Plug 'romainl/vim-cool'
Plug 'TaDaa/vimade'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot'
Plug 'srcery-colors/srcery-vim'
Plug 'vim-test/vim-test'
Plug 'voldikss/vim-floaterm'
Plug 'wincent/scalpel'
call plug#end()
" Enter current millenium
set nocompatible
set encoding=utf-8
" Backups and stuff
if exists('$SUDO_USER')
  set nobackup
  set nowritebackup
  set noswapfile
  if has('persistent_undo')
    set noundofile
  endif
else
  set backupdir=$HOME/.vim/backup//
  if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), 'p')
  endif
  set directory=$HOME/.vim/swapfiles//
  if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), 'p')
  endif
  if has('persistent_undo')
    set undofile
    set undodir=$HOME/.vim/undodir//
    if !isdirectory(expand(&undodir))
      call mkdir(expand(&undodir), 'p')
    endif
  endif
endif
" Sets backspace to work in case it doesn't
set backspace=indent,eol,start
let mapleader = '`'
" Removes /usr/include from path
set path-=/usr/include
" Enable syntax highlighting
syntax on
filetype plugin indent on
if has('syntax')
  set cursorline
endif
" Make default clipboard the OS X clipboard (and unnamedplus for Linux)
if has('clipboard')
  set clipboard=unnamed,unnamedplus
endif
" Formats stuff as I want, TAB=2spaces, but intelligent
set autoindent
set tabstop=8
set softtabstop=2
set expandtab
set shiftwidth=2
set smarttab
" Start scrolling 10 lines before the end
set scrolloff=10
" Folding
if has('folding')
  set foldmethod=indent
  set foldlevelstart=3
endif
" Highlight current line number
set highlight+=N:DiffText
" List stuff
set list
set listchars=
set listchars+=nbsp:⦸,trail:·,tab:»·,eol:↲
" Split stuff
if has('windows')
  set splitbelow
endif
if has('vertsplit')
  set splitright
endif
" Pretty terminal
if has('termguicolors')
  set termguicolors
  set t_Co=256
endif
" Allow cursor to move where there is no text in visual block mode
if has('virtualedit')
  set virtualedit=block
endif
" Disable error bells
if exists('&noerrorbells')
  set noerrorbells
endif
" Display all matching files when tab complete
if has('wildmenu')
  set wildmenu
endif
" Enable line numbers
set number
if exists('&relativenumber')
  set relativenumber
endif
if has('signs')
  set signcolumn=yes
endif
" Enable mouse support
if has('mouse')
  set mouse=a
endif
" Enable statusline
if has('statusline')
  set laststatus=2
endif
" Highlight matching pairs as you type: (), [], {}
set showmatch
if has('extra_search')
  " Search-as-you-type
  set incsearch
  " Use highlighting for search matches (:nohlsearch to clear [or :noh])
  set hlsearch
endif
" Case-insensitive searching
set ignorecase
" Case-sensitive if expression contains a capital letter
set smartcase
" Disable showmode
set noshowmode
" TextEdit might fail if hidden is not set.
set hidden
" Give more space for displaying messages.
set cmdheight=2
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience.
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" RipGrep to the rescue!
if executable('rg')
  set grepprg=rg\ --smart-case\ --vimgrep\ --hidden
  set grepformat=%f:%l:%c:%m
endif
" Remove extra white spaces
function! <sid>trimWhitespace() abort
  let l = line('.')
  let c = col('.')
  keepp %s/\s\+$//e
  call cursor(l, c)
endfunction
" Sudo write
command! Write !sudo tee % > /dev/null
" Y yanks to the end of the line
nnoremap Y y$
" ctrl+d & ctrl+u feels weird, so remap for ctrl+j & ctrl+k
noremap <c-j> <c-d>
noremap <c-k> <c-u>
noremap <c-d> <nop>
noremap <c-u> <nop>
" Auto closes brackets
inoremap { {}<esc>i
inoremap ( ()<esc>i
inoremap [ []<esc>i
inoremap < <><esc>i
" Auto closes marks
inoremap " ""<esc>i
inoremap ` ``<esc>i
" Terminal escape
tnoremap <leader><esc> <c-\><c-n>
" vimdiff specific
if &diff
  nnoremap <leader>1 :diffget LOCAL<cr>
  nnoremap <leader>2 :diffget BASE<cr>
  nnoremap <leader>3 :diffget REMOTE<cr>
  " Make it like vim-fugitive conflict
  nnoremap <leader>o 2<c-w>w<bar>:buffer 4<cr><bar>4<c-w>w<bar><c-w>c<bar>2<c-w>w
endif
" Show documentation
function! <sid>show_documentation()
  if (index(['vim', 'help'], &filetype) >= 0)
    execute 'h ' . expand('<cword>')
  else
    execute '!' . &keywordprg . ' ' . expand('<cword>')
  endif
endfunction
inoremap <silent> <leader>k <esc>:call <sid>show_documentation()<cr>
nnoremap <silent> <leader>k :call <sid>show_documentation()<cr>
"" Gruvbox Config Start
let g:gruvbox_italic = 1
let g:gruvbox_contrast_dark = 'hard'
"colorscheme gruvbox
"" Srcery Config Start
let g:srcery_italic = 1
colorscheme srcery
set background=dark
"" Clean-path Config Start
let g:clean_path_wildignore = 1
"" vim-cool Config Starts
let g:CoolTotalMatches = 1
"" Vimade Config Start
let g:vimade = {
      \ 'fadelevel': 0.2,
      \ 'usecursorhold': 1
      \ }
"" Undotree Config Start
inoremap <silent> <leader>u <esc>:UndotreeToggle<cr>
nnoremap <silent> <leader>u :UndotreeToggle<cr>
"" Floaterm Config Start
let g:floaterm_wintype = 'vsplit'
let g:floaterm_width = 0.5
"" Vim-select Config Start
let g:select_no_ignore_vcs = 0
" A bunch of fuzzy
inoremap <leader>sp <esc>:Select projectfile<cr>
nnoremap <leader>sp :Select projectfile<cr>
inoremap <leader>sb <esc>:Select buffer<cr>
nnoremap <leader>sb :Select buffer<cr>
inoremap <leader>st <esc>:Select floaterm<cr>
nnoremap <leader>st :Select floaterm<cr>
inoremap <leader>sd <esc>:Select todo<cr>
nnoremap <leader>sd :Select todo<cr>
inoremap <leader>sg <esc>:Select gitfile<cr>
nnoremap <leader>sg :Select gitfile<cr>
inoremap <leader>s/ <esc>:Select bufline<cr>
nnoremap <leader>s/ :Select bufline<cr>
"" vim-test Config Start
nnoremap <leader>tf :TestFile -strategy=floaterm<cr>
nnoremap <leader>ts :TestSuite -strategy=floaterm<cr>
nnoremap <leader>tv :TestVisit -strategy=floaterm<cr>
"" Scalpel Config Start
let g:ScalpelMap=0
nmap <leader><f2> <plug>(Scalpel)
"" Fern
let g:fern#disable_default_mappings = 1
let g:fern#default_hidden = 1
let g:fern#drawer_width = 40
let g:fern#renderer = 'nerdfont'
inoremap <silent><c-b> <esc>:Fern . -drawer -toggle -reveal=%<cr>
nnoremap <silent><c-b> :Fern . -drawer -toggle -reveal=%<cr>
"" vim-highlightedyank Config Start
let g:highlightedyank_highlight_duration = 250
"" ALE Config Start
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
set completeopt=menu,menuone,popup,noselect,noinsert
set omnifunc+=ale#completion#OmniFunc
function! <sid>check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <tab>
      \ pumvisible() ? "\<c-n>" :
      \ <sid>check_back_space() ? "\<tab>" :
      \ "<c-x><c-o>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"
imap <c-@> <plug>(ale_complete)
nmap gd <plug>(ale_go_to_definition)
nmap gy <plug>(ale_go_to_type_definition)
nmap gr <plug>(ale_find_references)
nnoremap <f2> :ALERename<cr>
nmap <c-h> <plug>(ale_previous_wrap)
imap <c-h> <plug>(ale_previous_wrap)
nmap <c-l> <plug>(ale_next_wrap)
imap <c-l> <plug>(ale_next_wrap)
"" Lightline Config Start
let g:lightline = {
      \ 'active': {
      \   'left': [['mode', 'paste'],
      \           ['gitbranch', 'readonly', 'filename', 'modified']],
      \   'right': [['linter_checking',
      \              'linter_errors',
      \              'linter_warnings',
      \              'linter_infos',
      \              'linter_ok'],
      \             ['percent',
      \              'lineinfo'],
      \             ['fileformat',
      \              'fileencoding',
      \              'filetype']],
      \   },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name',
      \   },
      \ 'component_type': {
      \   'linter_checking': 'right',
      \   'linter_infos': 'right',
      \   'linter_warnings': 'warning',
      \   'linter_errors': 'error',
      \   'linter_ok': 'right',
      \   },
      \ 'component_expand': {
      \   'linter_checking': 'lightline#ale#checking',
      \   'linter_infos': 'lightline#ale#infos',
      \   'linter_warnings': 'lightline#ale#warnings',
      \   'linter_errors': 'lightline#ale#errors',
      \   'linter_ok': 'lightline#ale#ok',
      \   }
      \ }
"let g:lightline.colorscheme = 'gruvbox'
let g:lightline.colorscheme = 'srcery'
" AutoCommands
augroup General
  autocmd!
  " Remove extra spaces on save
  autocmd BufWritePre,FileWritePre * :call <sid>trimWhitespace()
  " Add GrepQuickfix window
  autocmd QuickFixCmdPost cgetexpr cwindow
  autocmd QuickFixCmdPost lgetexpr lwindow
  " Close the completion window when done
  autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
augroup END

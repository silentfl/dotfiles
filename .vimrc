set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}
Plugin 'solarized'
Plugin 'wombat256.vim'
Plugin 'rails.vim'
Plugin 'The-NERD-tree'
Plugin 'The-NERD-Commenter'
Plugin 'fatih/vim-go'
"Plugin 'Shougo/neocomplete.vim'
Plugin 'valloric/youcompleteme'
Plugin 'kchmck/vim-coffee-script'
Plugin 'bling/vim-airline'
Plugin 'motemen/git-vim'
Plugin 'Tagbar'
Plugin 'dart-lang/dart-vim-plugin'
Plugin 'tpope/vim-markdown'
Plugin 'airblade/vim-gitgutter'
"Plugin 'stefanoverna/vim-i18n'
Plugin 'tpope/vim-surround'
"Plugin 'stefanoverna/vim-i18n'   " conflict with folding!
"Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'maksimr/vim-jsbeautify'
"Plugin 'hobbestigrou/vimtips-fortune'
"Plugin 'jaredly/vim-debug'
"Plugin 'vim-scripts/vimgdb'
"Plugin 'slim-template/vim-slim'
Plugin 'tpope/vim-haml'
"Plugin 'tslim'
Plugin 'slim-template/vim-slim'
"Plugin 'fholgado/minibufexpl.vim'  "window with buffers list
Plugin 'gregsexton/gitv'
Plugin 'powerman/vim-plugin-ruscmd'
Plugin 'vitalk/vim-simple-todo'
Plugin 'mattn/go-errcheck-vim'
Plugin 'mileszs/ack.vim'
Plugin 'elzr/vim-json'
Plugin 'ngmy/vim-rubocop'
Plugin 'astashov/vim-ruby-debugger'
Plugin 'danchoi/ri.vim'
Plugin 'skwp/vim-rspec'
Plugin 'AndrewRadev/splitjoin.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

syntax enable
filetype plugin indent on


filetype on
"filetype plugin on
set nowrap
set t_Co=256
set rnu	"relative number
set number
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab
set autoindent
set smartindent
syntax on
set mouse=a

" search
set ignorecase " ics - поиск без учёта регистра символов
set smartcase " - если искомое выражения содержит символы в верхнем регистре - ищет с учётом регистра, иначе - без учёта
set nohlsearch " (не)подсветка результатов поиска (после того, как поиск закончен и закрыт)
set incsearch " поиск фрагмента по мере его набора

set wildmenu
set wildmode=full
"colorscheme solarized
colorscheme wombat256mod
" show a vertical line on a 80th character
"set textwidth=80
"set colorcolumn=+1
"highlight ColorColumn ctermbg=LightYellow

"debian bug with backspace key in insert mode
set backspace=indent,eol,start

"Plugin settings
let g:airline_theme='molokai'
let g:airline_section_b = "%{GitBranch()}"
"let &colorcolumn=join(range(81,999),",")

"http://habrahabr.ru/blogs/vim/40369/
function! Run_C()
  if filereadable("Makefile")
    set makeprg=make
    map <f5>      :w<cr>:make<cr>:cw<cr>:!./%<<cr>
    imap <f5> <esc>:w<cr>:make<cr>:cw<cr>:!./%<<cr>
  else
    map <f5>      :w<cr>:make %:r<cr>:cw<cr>:!./%<<cr>
    imap <f5> <esc>:w<cr>:make %:r<cr>:cw<cr>:!./%<<cr>
  endif
endfunction

function! Build_C()
  if filereadable("Makefile")
    set makeprg=make
    map <f6>      :w<cr>:make<cr>:cw<cr>
    imap <f6> <esc>:w<cr>:make<cr>:cw<cr>
  else
    map <f6>      :w<cr>:make %:r<cr>:cw<cr>
    imap <f6> <esc>:w<cr>:make %:r<cr>:cw<cr>
  endif
endfunction

function! Run_Golang()
  if filereadable("Makefile")
    set makeprg=make
    map <f5>      :w<cr>:make<cr>:cw<cr>:!./%<<cr>
    imap <f5> <esc>:w<cr>:make<cr>:cw<cr>:!./%<<cr>
  else
    map <f5>      :w<cr>:GoRun<cr>:cw<cr>:!./%<<cr>
    imap <f5> <esc>:w<cr>:GoRun<cr>:cw<cr>:!./%<<cr>
  endif
endfunction

function! Build_Golang()
  if filereadable("Makefile")
    set makeprg=make
    map <f6>      :w<cr>:make<cr>:cw<cr>
    imap <f6> <esc>:w<cr>:make<cr>:cw<cr>
  else
    map <f6>      :w<cr>:GoBuild<cr>
    imap <f6> <esc>:w<cr>:GoBuild<cr>
  endif
endfunction

au FileType c,cc,cpp,h,hpp,s call Run_C()
au FileType c,cc,cpp,h,hpp,s call Build_C()
au FileType go call Run_Golang()
au FileType go call Build_Golang()

augroup nonvim
  au!
  au BufRead *.png,*.jpg,*.pdf,*.gif,*.xls* sil exe "!xdg-open " . shellescape(expand("%:p")) | bd | let &ft=&ft
augroup end

map <F3> :NERDTreeToggle<CR>
map <F9> :TagbarToggle<CR>
vmap <Leader>m :call I18nTranslateString()<CR>  "standart hotkey (<leader>z) conflict with folding

au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

"vmap <Leader>z :call I18nTranslateString()<CR>
vmap <F10> :call I18nTranslateString()<CR>

au FileType javascript nmap gg=G :call JsBeautify()<cr>
au FileType html nmap gg=G :call HtmlBeautify()<cr>
au FileType css nmap gg=G :call CSSBeautify()<cr>
au BufRead,BufNewFile *.thor set filetype=ruby

" Disable default key bindings for vim-simple-todo
let g:simple_todo_map_keys = 0
nmap <Leader>ti <Plug>(simple-todo-new)
imap <Leader>ti <Plug>(simple-todo-new)
nmap <Leader>to <Plug>(simple-todo-below)
imap <Leader>to <Plug>(simple-todo-below)
nmap <Leader>tO <Plug>(simple-todo-above)
imap <Leader>tO <Plug>(simple-todo-above)
nmap <Leader>tx <Plug>(simple-todo-mark-as-done)
imap <Leader>tx <Plug>(simple-todo-mark-as-done)
nmap <Leader>tX <Plug>(simple-todo-mark-as-undone)
imap <Leader>tX <Plug>(simple-todo-mark-as-undone)

nmap gs <c-w><c-v><c-w>l:A<cr>
nmap <f2> :RunSpec<cr>

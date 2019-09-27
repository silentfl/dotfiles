set nocompatible
set encoding=utf-8
filetype off                           " required

"********************************************************************************
" Vundle
"--------------------------------------------------------------------------------
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
" Filesystem
"--------------------------------------------------------------------------------
Plugin 'The-NERD-tree'
Plugin 'The-NERD-Commenter'
" Plugin 'fholgado/minibufexpl.vim'    " window with buffers list
Plugin 'wincent/command-t'

" Themes
"--------------------------------------------------------------------------------
Plugin 'solarized'
Plugin 'wombat256.vim'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Syntax
"--------------------------------------------------------------------------------
Plugin 'elzr/vim-json'
Plugin 'tpope/vim-haml'
Plugin 'slim-template/vim-slim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'tpope/vim-markdown'
Plugin 'scrooloose/syntastic'
Plugin 'posva/vim-vue'
Plugin 'elixir-editors/vim-elixir'

" Git
"--------------------------------------------------------------------------------
Plugin 'motemen/git-vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'gregsexton/gitv'
Plugin 'tpope/vim-fugitive'
Plugin 'vitapluvia/vim-gurl'

" Tools
"--------------------------------------------------------------------------------
Plugin 'valloric/youcompleteme'
" Plugin 'Shougo/neocomplete.vim'
Plugin 'mileszs/ack.vim'
Plugin 'ngmy/vim-rubocop'
Plugin 'skwp/vim-rspec'
Plugin 'szw/vim-tags'
Plugin 'powerman/vim-plugin-ruscmd'

" Code tools
"--------------------------------------------------------------------------------
Plugin 'Tagbar'
Plugin 'rails.vim'
Plugin 'tpope/vim-surround'
Plugin 'AndrewRadev/splitjoin.vim'     " ruby {} <-> do; end: gS, gJ
Plugin 'stefanoverna/vim-i18n'         " has conflict with folding by <leader>z
                                       " <leader>dt, <leader>m, <F10>

" Golang
"--------------------------------------------------------------------------------
Plugin 'fatih/vim-go'
Plugin 'mattn/go-errcheck-vim'
Plugin 'nsf/gocode', {'rtp': 'vim/'}

call vundle#end()                      " required
filetype plugin indent on              " required

" Main settings
"********************************************************************************
syntax enable
filetype plugin indent on

filetype on
" filetype plugin on
set nobackup
set noswapfile
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
set clipboard=unnamedplus

" show a vertical line on a 80th character
set textwidth=80
set colorcolumn=+1
highlight ColorColumn ctermbg=Gray
" highlight ColorColumn ctermbg=LightYellow

" debian bug with backspace key in insert mode
set backspace=indent,eol,start

" colorscheme torte
" colorscheme solarized
" colorscheme peachpuff 
colorscheme wombat256mod
"
" Переключение цвета не очень, airline периодически пропадает
" autocmd BufEnter * colorscheme solarized
" autocmd BufEnter *.ex colorscheme peachpuff
" autocmd BufEnter *.exs colorscheme peachpuff

" Completion
"--------------------------------------------------------------------------------
set wildmenu
set wildmode=full

" Search
"--------------------------------------------------------------------------------
set ignorecase                         " ics поиск без учёта регистра символов
set smartcase                          " если искомое выражения содержит символы
                                       " в верхнем регистре - ищет с учётом
                                       " регистра, иначе - без учёта
set nohlsearch                         " (не)подсветка результатов поиска
                                       " (после окончания и закрытия поиска)
set incsearch                          " поиск фрагмента по мере его набора

" Plugin settings
"--------------------------------------------------------------------------------
let g:airline_theme='molokai'
let g:airline_section_b = "%{GitBranch()}"
" let &colorcolumn=join(range(81,999),",")
let g:NERDSpaceDelims = 1
let g:vimgurl_yank_register = '+' " :call Gurl() -> copy url to clipboard
let g:ackprg = 'ag --nogroup --nocolor --column --ignore=translations.js'
" Open files by external tool
"--------------------------------------------------------------------------------
augroup nonvim
  au!
  au BufRead *.png,*.jpg,*.pdf,*.gif,*.xls* sil exe "!xdg-open " . shellescape(expand("%:p")) | bd | let &ft=&ft
augroup end

" Bindings
"--------------------------------------------------------------------------------
map <F3> :NERDTreeToggle<CR>
map <F9> :TagbarToggle<CR>
nmap gs <c-w><c-v><c-w>l:A<cr>         " open spec file
nmap <F2> :RunSpec<cr>
nmap <F8> :cn<cr>                      " next error
nmap <C-k> :Ack "<cword>"<CR>          " search by current word
noremap <leader>gr :call Gurl()<CR>

" standart hotkey (<leader>z) conflict with folding
vmap <Leader>m :call I18nTranslateString()<CR>
vmap <F10> :call I18nTranslateString()<CR>
nmap <Leader>dt :call I18nDisplayTranslation()<CR>

" Bindings by filetype
"--------------------------------------------------------------------------------
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

au FileType javascript nmap gg=G :call JsBeautify()<cr>
au FileType html nmap gg=G :call HtmlBeautify()<cr>
au FileType css nmap gg=G :call CSSBeautify()<cr>

au FileType c,cc,cpp,h,hpp,s call Run_C()
au FileType c,cc,cpp,h,hpp,s call Build_C()
au FileType go call Run_Golang()
au FileType go call Build_Golang()

" Syntax highlight
"--------------------------------------------------------------------------------
au BufRead,BufNewFile *.thor set filetype=ruby

" Functions
"--------------------------------------------------------------------------------
" http://habrahabr.ru/blogs/vim/40369/
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

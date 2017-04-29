" ======================================================================== "
" Bundle plug-in packaging system SETTINGS
" ======================================================================== "
" Bundle setting from https://github.com/gmarik/vundle#readme
"   Sumarry
"     git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"     vim -c BundleInstall
set nocompatible               " be iMproved
filetype off                   " required!
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.fzf

call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" My Bundles here:
"
" original repos on github
Plugin 'tpope/vim-fugitive'
" Plugin 'Lokaltog/vim-easymotion'
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" vim-scripts repos
Plugin 'vcscommand.vim'
" Plugin 'svndiff'
Plugin 'clang-complete'

Plugin 'darkslategray.vim'
Plugin 'matrix.vim'
Plugin 'matrix.vim--Yang'
Plugin 'freya'
Plugin 'jellybeans.vim'
Plugin 'PapayaWhip'
Plugin 'Relaxed-Green'
Plugin 'Zenburn'
Plugin 'lifepillar/vim-solarized8'
" Plugin 'all-colors-pack'
" Plugin 'L9'
" Plugin 'FuzzyFinder'
" Plugin 'rails.vim'
" non github repos
" Plugin 'https://github.com/wincent/Command-T'
Plugin 'ctrlp.vim'
Plugin 'https://github.com/aaronbieber/quicktask'
Plugin 'bling/vim-airline'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tpope/vim-obsession'
Plugin 'mgedmin/chelper.vim'

Plugin 'wesleyche/SrcExpl'  

Plugin 'will133/vim-dirdiff'

" Plugin 'xiaoshuan/showmarks.vim'
Plugin 'taglist.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'wesleyche/Trinity.git'

" Plugin 'cscope.git'
" Plugin 'cscope_macros.vim'
Plugin 'ronakg/quickr-cscope.vim'
" Plugin 'cscope-quickfix'
" ...

Plugin 'stefandtw/quickfix-reflector.vim'

call vundle#end()
filetype plugin indent on     " required! 
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..



" ======================================================================== "
" BASIC SETTINGS
" ======================================================================== "
set tags=tags
set tags+=~/.vim/jumptags
set tags+=./tags
set tags+=./src/tags
set tags+=./../tags
set tags+=./../../tags
set tags+=./../../../tags
set tags+=./../../../../tags
set tags+=./../../../../../tags
set tags+=./../../../../../../tags
set tags+=./../../../../../../../tags
set tags+=./../../../../../../../../tags
set tags+=./../../../../../../../../../tags
set tags+=./../../../../../../../../../../tags
set tags+=./../../../../../../../../../../../tags
set tags+=./../../../../../../../../../../../../tags
set tags+=./../../../../../../../../../../../../../tags
set tags+=./../../../../../../../../../../../../../../tags
set tags+=./../../../../../../../../../../../../../../../tags

set nocompatible               " be iMproved
set hlsearch
set ruler
set ts=4 sts=4 sw=4 expandtab
set incsearch
set mouse=

autocmd CursorMoved * silent! exe printf('match IncSearch /\<%s\>/', expand('<cword>'))

" set cursorcolumn
" set cursorline

" let mapleader = "_"

" vmap gl :<C-U>!svn blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
" vmap gc :w! ~/.tmp12345<CR>
" noremap <leader>p :r ~/.tmp12345<CR>

" cscope result to quickfix
" set cscopequickfix=s-,c-,d-,i-,t-,e-   

" for quickfix list
" autocmd BufReadPost quickfix set modifiable
noremap <C-p> :cp<CR>
noremap <C-n> :cn<CR>
" noremap <C-l> :cla<CR>
" noremap <C-h> :cr<CR>
inoremap <C-g> <ESC>
nnoremap <C-g> :ccl<CR>
nnoremap <leader>q :qa!<CR>

let g:newgrp="grp"
function! NewGrep(args)
    let grepprg_bak=&grepprg
    exec "set grepprg=" . g:newgrp
    execute "silent! grep " . a:args
    botright copen
    let &grepprg=grepprg_bak
    exec "redraw!"
endfunction
command! -nargs=* -complete=file NewGrep call NewGrep(<q-args>)
" grep for current word
noremap <C-a> :NewGrep <C-r><C-w><CR>

noremap <leader>r :w<CR>:!%:p<CR>



" ======================================================================== "
" Plug-in specific SETTINGS
" ======================================================================== "
" for svndiff

" noremap <C-p> :call Svndiff("prev")<CR>
" noremap <C-n> :call Svndiff("next")<CR>
" noremap <C-i> :call Svndiff("clear")<CR>
" let g:svndiff_autoupdate = 1
" let g:svndiff_one_sign_delete = 1
" hi DiffAdd      ctermfg=0 ctermbg=2 guibg='green'
" hi DiffDelete   ctermfg=0 ctermbg=1 guibg='red'
" hi DiffChange   ctermfg=0 ctermbg=3 guibg='yellow'

" for clang-components
let g:clang_complete_auto = 0
let g:clang_complete_copen = 1

" ctrl-p
let g:ctrlp_map = '\t'
" let g:ctrlp_user_command = 'find %s -type f'

let g:ctrlp_custom_ignore = {
      \ 'dir': '\.git$\|\.hg$\|\.svn$\|__pycache__$' . $CTRLP_IGNORE_DIR_OPTIONS,
      \ 'file': '\.pyc$\|\.so$\|\.swp$\|\.o$',
      \ }

au VimEnter,VimResized * let g:ctrlp_max_height = &lines

" http://vimcasts.org/episodes/show-invisibles/
nmap <leader>l :set list!<CR>
set list
" set listchars=tab:»\ ,eol:¬
"set listchars=tab:>-,eol:$
set listchars=tab:>-
highlight NonText guifg=#974652
highlight SpecialKey guifg=#974652

" colo zenburn

" private
nnoremap ~ A<C-V>	 <ESC>
let g:svndiff_ignore_whitespace_tail = 1

" for airline
set laststatus=2

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap L :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
nnoremap K :vsp<CR><C-W>l:grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
nnoremap <F1> A<C-v>u<TAB><ESC>j
nnoremap <F2> A<C-v>u<TAB><C-v>u<TAB><ESC>j
nnoremap <F3> A<C-v>u<TAB> <C-v>u<TAB><ESC>j

" for going to beginning of functiion whose starting brace is not on first
" column
map [[ ?{<CR>w99[{
map ][ /}<CR>b99]}
map ]] j0[[%/{<CR>
map [] k$][%?}<CR>

function! YankHook()
    call system("go", @0 . "\n")
    redraw!
endfunction

vnoremap <silent> y y:call YankHook()<cr>
nnoremap <silent> yy yy:call YankHook()<cr>

function! PushHere()
    execute "silent !tagpush %:p"
    execute "normal! i___virttag___\<esc>hhhhhhhhhhhh:tag ___virttag___\<CR>u"
    exec "redraw!"
endfunction

nnoremap <silent> mm mm:call PushHere()<cr>

colorscheme solarized8_dark_low

" for truecolor support
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

syntax on

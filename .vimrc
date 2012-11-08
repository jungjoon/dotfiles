" ======================================================================== "
" BASIC SETTINGS
" ======================================================================== "
set tags=tags,./tags,../tags,../../tags,../../../tags,../../../../tags,../../../../../tags,../../../../../../tags,../../../../../../../tags

set nocompatible               " be iMproved
set hlsearch
set ruler
set ts=4 sts=4 sw=4 expandtab
set incsearch
set mouse=a

autocmd CursorMoved * silent! exe printf('match IncSearch /\<%s\>/', expand('<cword>'))

" let mapleader = "_"

vmap gl :<C-U>!svn blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
vmap gc :w! ~/.tmp12345<CR>
noremap <leader>p :r ~/.tmp12345<CR>

" for quickfix list
noremap <C-j> :cn<CR>
noremap <C-k> :cp<CR>
" noremap <C-h> :cr<CR>
" noremap <C-l> :cla<CR>
imap <C-g> <ESC>

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
noremap <C-a> :NewGrep <C-r><C-w> .<CR>

noremap <leader>r :w<CR>:!%:p<CR>


" ======================================================================== "
" Bundle plug-in packaging system SETTINGS
" ======================================================================== "
" Bundle setting from https://github.com/gmarik/vundle#readme
"   Sumarry
"     git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
"     vim -c BundleInstall
filetype off                   " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
" Bundle 'tpope/vim-fugitive'
" Bundle 'Lokaltog/vim-easymotion'
" Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
" vim-scripts repos
Bundle 'vcscommand.vim'
Bundle 'svndiff'
Bundle 'clang-complete'

Bundle 'darkslategray.vim'
Bundle 'matrix.vim'
Bundle 'matrix.vim--Yang'
Bundle 'freya'
Bundle 'jellybeans.vim'
Bundle 'PapayaWhip'
Bundle 'Relaxed-Green'
Bundle 'Zenburn'
" Bundle 'all-colors-pack'
" Bundle 'L9'
" Bundle 'FuzzyFinder'
" Bundle 'rails.vim'
" non github repos
" Bundle 'https://github.com/wincent/Command-T'
Bundle 'taglist.vim'
Bundle 'ctrlp.vim'
Bundle 'https://github.com/aaronbieber/quicktask'
" ...

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
" Plug-in specific SETTINGS
" ======================================================================== "
" for svndiff
noremap <C-p> :call Svndiff("prev")<CR>
noremap <C-n> :call Svndiff("next")<CR>
noremap <C-i> :call Svndiff("clear")<CR>
let g:svndiff_autoupdate = 1
let g:svndiff_one_sign_delete = 1
hi DiffAdd      ctermfg=0 ctermbg=2 guibg='green'
hi DiffDelete   ctermfg=0 ctermbg=1 guibg='red'
hi DiffChange   ctermfg=0 ctermbg=3 guibg='yellow'

" for clang-components
let g:clang_complete_auto = 0
let g:clang_complete_copen = 1

" ctrl-p
let g:ctrlp_map = '\t'
" let g:ctrlp_user_command = 'find %s -type f'

" http://vimcasts.org/episodes/show-invisibles/
nmap <leader>l :set list!<CR>
set listchars=tab:»\ ,eol:¬
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" colo zenburn

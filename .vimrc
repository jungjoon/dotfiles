" ======================================================================== "
" Bundle plug-in packaging system SETTINGS
" ======================================================================== "
" Bundle setting from https://github.com/gmarik/vundle#readme
"   Sumarry
"     git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"     vim -c BundleInstall

syntax on
set nocompatible               " be iMproved
filetype off                   " required!
set rtp+=~/.vim/bundle/Vundle.vim

if has("nvim")
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif 

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
Plugin 'svndiff'
Plugin 'clang-complete'

Plugin 'darkslategray.vim'
Plugin 'matrix.vim'
Plugin 'matrix.vim--Yang'
Plugin 'freya'
Plugin 'jellybeans.vim'
Plugin 'PapayaWhip'
Plugin 'Relaxed-Green'
Plugin 'Zenburn'
Plugin 'badwolf'
Plugin 'morhetz/gruvbox'
" Plugin 'all-colors-pack'
" Plugin 'L9'
" Plugin 'FuzzyFinder'
" Plugin 'rails.vim'
" non github repos
" Plugin 'https://github.com/wincent/Command-T'
Plugin 'taglist.vim'
Plugin 'ctrlp.vim'
Plugin 'https://github.com/aaronbieber/quicktask'
Plugin 'bling/vim-airline'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tpope/vim-obsession'
" ...

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
noremap <C-a> :NewGrep <C-r><C-w><CR>

noremap <leader>r :w<CR>:!%:p<CR>



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

let g:ctrlp_custom_ignore = {
      \ 'dir': '\.git$\|\.hg$\|\.svn$\|__pycache__$' . $CTRLP_IGNORE_DIR_OPTIONS,
      \ 'file': '\.pyc$\|\.so$\|\.swp$\|\.o$',
      \ }

au VimEnter,VimResized * let g:ctrlp_max_height = &lines

" http://vimcasts.org/episodes/show-invisibles/
" nmap <leader>l :set list!<CR>
" set listchars=tab:»\ ,eol:¬
" highlight NonText guifg=#4a4a59
" highlight SpecialKey guifg=#4a4a59

colo badwolf

" private
nnoremap ~ A<C-V>	 <ESC>
let g:svndiff_ignore_whitespace_tail = 1

" for airline
set laststatus=2


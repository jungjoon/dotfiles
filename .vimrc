" ======================================================================== "
" Bundle plug-in packaging system SETTINGS
" ======================================================================== "
" Bundle setting from https://github.com/gmarik/vundle#readme
"   Sumarry
"     git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"     vim -c BundleInstall
set nocompatible               " be iMproved
filetype on                   " required!
syntax on

" allow to use more memory
set hidden
set history=100

set ts=4 sts=4 sw=4 expandtab
set nowrap
set hlsearch
set incsearch
set mouse=

set showmatch
set showcmd

" set ignorecase


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
" Plugin 'clang-complete'

Plugin 'darkslategray.vim'
Plugin 'matrix.vim'
Plugin 'matrix.vim--Yang'
Plugin 'freya'
Plugin 'jellybeans.vim'
Plugin 'PapayaWhip'
Plugin 'Relaxed-Green'
Plugin 'Zenburn'
Plugin 'TagHighlight'
Plugin 'lifepillar/vim-solarized8'
" Plugin 'ervandew/supertab'
" Plugin 'all-colors-pack'
" Plugin 'L9'
" Plugin 'FuzzyFinder'
" Plugin 'rails.vim'
" non github repos
" Plugin 'https://github.com/wincent/Command-T'
Plugin 'ctrlp.vim'
Plugin 'https://github.com/aaronbieber/quicktask'
Plugin 'bling/vim-airline'
Plugin 'majutsushi/tagbar'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tpope/vim-obsession'
Plugin 'mgedmin/chelper.vim'

Plugin 'wesleyche/SrcExpl'  

Plugin 'will133/vim-dirdiff'

" Plugin 'xiaoshuan/showmarks.vim'
" Plugin 'taglist.vim'
" Plugin 'scrooloose/nerdtree'
" Plugin 'wesleyche/Trinity.git'

" Plugin 'cscope.git'
" Plugin 'cscope_macros.vim'
Plugin 'ronakg/quickr-cscope.vim'
" Plugin 'cscope-quickfix'
" ...

Plugin 'stefandtw/quickfix-reflector.vim'
" Plugin 'dhruvasagar/vim-markify'
Plugin 'MattesGroeger/vim-bookmarks'

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
" TODO use environment variable (TAG) to store name of tag file. so that we can work with different arch (with each tag for each arch)
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
set tags+=./../../../../../../../../../../../../../../../../tags
set tags+=./../../../../../../../../../../../../../../../../../tags

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
vnoremap <C-g> <ESC>
" close quickfix
nnoremap <silent> <C-g> :ccl<CR>:nohlsearch<CR>
nnoremap <leader>q :qa!<CR>
nnoremap <C-q> :qa!<CR>     " TODO why this doesn't work

" for C-] to use tjump (that asks if there's multiple defs) instead of tag
nnoremap <c-]> g<c-]>
vnoremap <c-]> g<c-]>
nnoremap g<c-]> <c-]>
vnoremap g<c-]> <c-]>

" for 'edit previous file'
nnoremap <leader><leader> :e#<cr>

if executable('ag') == 0
    error, sorry, I *do* need ag.
end

" TODO refactoring - to merge RunAg and RunAgFlist (adding filter arg into RunAg)
function! RunAg(args)
    call PushHere()
    let grepprg_bak=&grepprg
    set grepprg=ag\ --nogroup\ --nocolor
    execute "silent! grep! " . a:args
    botright copen 15
    let &grepprg=grepprg_bak
    redraw!
endfunction

function! RunAgFlist(args)
    call PushHere()
    let grepprg_bak=&grepprg
    set grepprg=ag\ --nogroup\ --nocolor\ $*\ \\\|\ grep_flist
    execute "silent! grep! " . a:args
    botright copen 15
    let &grepprg=grepprg_bak
    redraw!
endfunction

command! -nargs=* -complete=file RunAg call RunAg(<q-args>)
nnoremap <leader>g :RunAg <C-r><C-w> -w

command! -nargs=* -complete=file RunAgFlist call RunAgFlist(<q-args>)
nnoremap <c-_> :RunAgFlist <C-r><C-w> -w

" ======================================================================== "
" Plug-in specific SETTINGS
" ======================================================================== "
" for svndiff

" noremap <C-p> :call Svndiff("prev")<CR>
" noremap <C-n> :call Svndiff("next")<CR>
" noremap <C-i> :call Svndiff("clear")<CR>
" let g:svndiff_autoupdate = 1
" let g:svndiff_one_sign_delete = 1
" let g:svndiff_ignore_whitespace_tail = 1
" hi DiffAdd      ctermfg=0 ctermbg=2 guibg='green'
" hi DiffDelete   ctermfg=0 ctermbg=1 guibg='red'
" hi DiffChange   ctermfg=0 ctermbg=3 guibg='yellow'

" for clang-components
" let g:clang_complete_auto = 0
" let g:clang_complete_copen = 1

" ctrl-p
let g:ctrlp_map = '\t'

let g:ctrlp_custom_ignore = {
      \ 'dir': '\.git$\|\.hg$\|\.svn$\|__pycache__$' . $CTRLP_IGNORE_DIR_OPTIONS,
      \ 'file': '\.pyc$\|\.so$\|\.swp$\|\.o$',
      \ }

au VimEnter,VimResized * let g:ctrlp_max_height = &lines

" Use ag in CtrlP for listing files. ag is enough fast to disable cache
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_use_caching = 0

" let g:ctrlp_user_command = 'find %s -type f'

" http://vimcasts.org/episodes/show-invisibles/
nmap <leader>l :set list!<CR>:set number!<CR>
set list
set number
" set listchars=tab:»\ ,eol:¬
"set listchars=tab:>-,eol:$
set listchars=tab:>-
highlight NonText guifg=#974652
highlight SpecialKey guifg=#974652

" colo zenburn

" private, inserting TAB to end
" nnoremap ~ A<C-V>	 <ESC>

" for airline
set laststatus=2
let g:airline#extensions#tagbar#enabled = 1

" bind K to grep word under cursor
" nnoremap L :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" nnoremap K :vsp<CR><C-W>l:grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" nnoremap <F1> A<C-v>u<TAB><ESC>j
" nnoremap <F2> A<C-v>u<TAB><C-v>u<TAB><ESC>j
" nnoremap <F3> A<C-v>u<TAB> <C-v>u<TAB><ESC>j

" for going to beginning of functiion whose starting brace is not on first column
map [[ ?{<CR>w99[{
map ][ /}<CR>b99]}
map ]] j0[[%/{<CR>
map [] k$][%?}<CR>

" function! YankHook()
"    call system("go", @0 . "\n")
"    redraw!
"endfunction
"
"vnoremap <silent> y y:call YankHook()<cr>
"nnoremap <silent> yy yy:call YankHook()<cr>

function! PushHere()
    execute "silent !tagpush %:p " . line(".") . " " . col(".")
    tag ___virttag___
    exec "redraw!"
endfunction

nnoremap <silent> mm mm:call PushHere()<cr>

colorscheme solarized8_dark_low

" for truecolor support
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" disable background-color-erase (tmux issue that doesn't color bg after EOL)
set t_ut=

map <leader>r :source ~/.vimrc<cr>


" TODO editable quickfix. it looks done but actually doesn't work properly, especially, I'd like to add entries... merging searching results


" delete all audocmd with default group
autocmd!

set nocompatible
filetype off

set hidden
set history=100

" et ts sts sw
set expandtab tabstop=4 softtabstop=4 shiftwidth=4
set autoindent

set encoding=utf-8

set nowrap
set hlsearch
set incsearch

set showmatch
set showcmd

set noeol
set nofixeol

set splitbelow
set splitright

set foldmethod=indent
set foldlevel=99
nnoremap <space> za

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

noremap <SPACE> <Nop>
let mapleader=" "

nnoremap <leader>q :qa!<CR>
" for 'edit previous file'
nnoremap <leader><leader><leader> :e#<CR>

" buffer list and prepare to switch
" replaced with denite
" nnoremap <leader>b :ls<CR>:b<SPACE>


function! PushHere()
    execute "silent !tagpush %:p " . line(".") . " " . col(".")
    tag ___virttag___
    exec "redraw!"
endfunction

nnoremap <silent> mm mm:call PushHere()<cr>

autocmd TermClose * :q

" (vim) curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" (nvim) sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
" :PlugInstall
call plug#begin("~/.vim/plugged")
" Plug 'Shougo/denite.nvim'
" Plug 'dracula/vim'
" Plug 'rafi/awesome-vim-colorschemes'
Plug 'arcticicestudio/nord-vim'
" Plug 'blueyed/vim-diminactive'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'dense-analysis/ale'
" Plug 'davidhalter/jedi-vhm'
" Plug 'ycm-core/YouCompleteMe'
" Plug 'neovim/nvim-lsp'
" Plug 'tmhedberg/SimpylFold'
" Plug 'thinca/vim-quickrun'
Plug 'Yggdroot/indentLine'
Plug 'ShikChen/osc52.vim'
Plug 'easymotion/vim-easymotion'
call plug#end()

filetype plugin indent on

" colorscheme dracula
colorscheme nord

hi StatusLine   ctermfg=15  guifg=#ffffff ctermbg=239 guibg=#949031 cterm=bold gui=bold
hi StatusLineNC ctermfg=249 guifg=#b2b2b2 ctermbg=237 guibg=#3a3a3a cterm=none gui=none

" Plug ShikChen/osc52.vim
vnoremap Y y:call SendViaOSC52(getreg('"'))<CR>

" Plugin semshi
" use semshi for highlight but not for lint/syntax check
let g:semshi#error_sign = v:false

" Plugin ale
let g:ale_linters = {
    \   'python': ['pylint'],
    \}
let g:ale_fixers = {
    \    'python': ['yapf'],
    \}
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? '✨ all good ✨' : printf(
                \   '😞 %dW %dE',
                \   all_non_errors,
                \   all_errors
                \)
endfunction

set statusline=
set statusline+=%m
set statusline+=\ %f
set statusline+=%=
set statusline+=\ %{LinterStatus()}


" " Plug nvim-lsp with pyls_ms
" packadd nvim-lsp
" lua << EOF
" require 'nvim_lsp'.pyls_ms.setup{
"     filetypes = { "python" }
"     init_options = {
"       analysisUpdates = true,
"       asyncStartup = true,
"       displayOptions = {},
"       interpreter = {
"         properties = {
"           InterpreterPath = "/usr/local/bin/python3.8",
"           Version = "3.8"
"         }
"       }
"     }
"     on_new_config = <function 1>
"     root_dir = vim's starting directory
"     settings = {
"       python = {
"         analysis = {
"           disabled = {},
"           errors = {},
"           info = {}
"         }
"       }
"     }
" }
" EOF

" Plug nvim_lsp with pyls
" pip3.8 install 'python-language-server[all]'

" register the language server
" let settings = {
"           \   "pyls" : {
"           \     "enable" : v:true,
"           \     "trace" : { "server" : "verbose", },
"           \     "commandPath" : "",
"           \     "configurationSources" : [ "pycodestyle" ],
"           \     "plugins" : {
"           \       "jedi_completion" : { "enabled" : v:true, },
"           \       "jedi_hover" : { "enabled" : v:true, },
"           \       "jedi_references" : { "enabled" : v:true, },
"           \       "jedi_signature_help" : { "enabled" : v:true, },
"           \       "jedi_symbols" : {
"           \         "enabled" : v:true,
"           \         "all_scopes" : v:true,
"           \       },
"           \       "mccabe" : {
"           \         "enabled" : v:true,
"           \         "threshold" : 15,
"           \       },
"           \       "preload" : { "enabled" : v:true, },
"           \       "pycodestyle" : { "enabled" : v:true, },
"           \       "pydocstyle" : {
"           \         "enabled" : v:false,
"           \         "match" : "(?!test_).*\\.py",
"           \         "matchDir" : "[^\\.].*",
"           \       },
"           \       "pyflakes" : { "enabled" : v:true, },
"           \       "rope_completion" : { "enabled" : v:true, },
"           \       "yapf" : { "enabled" : v:true, },
"           \     }}}
" call nvim_lsp#setup("pyls", settings)
" lua require('nvim_lsp').pyls.setup{}

" with lsp
" autocmd Filetype python
"   \ | setlocal omnifunc=v:lua.vim.lsp.omnifunc
"   \ | nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
"   \ | nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
"   \ | nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
"   \ | nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
"   \ | nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
"   \ | nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
"   \ | nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
"   \ | nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
"   \ | nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

" with YouCompleteMe
autocmd Filetype python
     \ | nnoremap <C-]> :call PushHere()<CR>:YcmCompleter GoToDefinition<CR>
     \ | nnoremap K :YcmCompleter GetDoc<CR>

if (has("termguicolors"))
 set termguicolors
endif

set splitright
inoremap <C-g> <Esc>
vnoremap <C-g> <Esc>
nnoremap <C-g> :w<CR>

" map <Leader>m <Plug>(easymotion-prefix)

nnoremap <leader>ve :e $MYVIMRC<CR>
nnoremap <leader>vr :source $MYVIMRC<CR>

noremap <C-o> <C-w>w
noremap <C-k> :hide<cr>
noremap <A-l> :vertical resize +5<CR>
noremap <A-h> :vertical resize -5<CR>
noremap <A-k> :resize +5<CR>
noremap <A-j> :resize -5<CR>

function OpenQuakeTerm()
    " if currently on qterm, toggles is_qterm_prohibit_autohide
    if exists("b:is_qterm")
        if !exists("b:is_qterm_prohibit_autohide")
            let b:is_qterm_prohibit_autohide = 1
            echo "Turned off auto-hide"
        else
            unlet b:is_qterm_prohibit_autohide
            echo "Turned on auto-hide"
        endif
        
        return
    endif

    for buf in getbufinfo({'buflisted':1})
        " echo buf
        if has_key(buf.variables, 'term_title')
            if has_key(buf.variables, 'is_qterm')
                " if it's already shown
                if !empty(buf.windows)
                    let l:winnr = win_id2win(buf.windows[0])
                    execute l:winnr . "wincmd w"
                    " win_gotoid(buf.windows[0])

                    return
                endif

                " if there's no windows
                execute "18split"
                " TODO why this doesn't work. buffer buf.bufnr
                execute "buffer " . buf.bufnr

                " restore height
                if exists("b:qterm_height")
                    " TODO why this doesn't work, it works as if resize ""  => resize b:qterm_height
                    execute "resize " . b:qterm_height
                endif
                " prefer start on insert mode right after window appears
                startinsert

                return
            endif
        endif
    endfor

    " if there's no existing qterm
    execute "18split term://$SHELL"
    execute "set number!"
    let b:is_qterm = 1
    " TODOMARK make it insert mode with 'a' (endof line)
    startinsert
endfunction

augroup QuakeTerminalEventGroup
  autocmd!
  autocmd WinLeave *
    \ | if exists("b:is_qterm")
    \ |   let b:qterm_height = winheight(0)
    \ |   if !exists("b:is_qterm_prohibit_autohide")
    \ |     if exists("b:twasimode")
    \ |     hide
    \ |     endif
    \ |   endif
    \ | endif
augroup END

if has('nvim')
  " Terminal setting
  " Esc/C-g for exit to normal mode
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-v><Esc> <Esc>
  tnoremap <C-g> <C-\><C-n>
  tnoremap <C-v><C-g> <C-g>
  nnoremap <leader>s :call OpenQuakeTerm()<CR>
  " TODO nnoremap <leader>S :vsplit term://$SHELL<CR>:set number!<CR>i

  tnoremap <silent> <C-o> <C-\><C-n>:let b:twasimode=1<CR><C-w>w
  tnoremap <silent> <leader><leader> <C-\><C-n>:let b:twasimode=1<CR>:e#<CR>
  augroup TerminalFocusSetImode
    autocmd!
    autocmd BufEnter *
        \ if exists("b:twasimode")
        \ | unlet b:twasimode
        \ | execute "normal! a"
        \ | endif
"    autocmd BufWinEnter *
"        \ echom "BufWinEnter: " . @%
"    autocmd BufEnter *
"        \ echom "BufEnter: " . @%
  augroup END
endif

" https://github.com/neovim/neovim/wiki/FAQ
" http://vimcasts.org/episodes/show-invisibles/
nmap <leader>l :set list!<CR>:set number!<CR>:set wrap!<CR>:IndentLinesToggle<CR>
set list
set number
" set listchars=tab:»\ ,eol:¬
"set listchars=tab:>-,eol:$
set listchars=tab:>-
"highlight NonText guifg=#974652
"highlight SpecialKey guifg=#974652

" https://codeyarns.com/2013/02/07/how-to-show-cursorline-only-in-active-window-of-vim/
augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END


" fzf mappings
nmap <leader>f :Files<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>h :History<CR>
nmap <leader>t :BTags<CR>
nmap <leader>T :Tags<CR>
nmap <leader>/ :Ag<space>
nmap <leader>c :Commands<CR>

" mapping for list location
nnoremap ge :ALENextWrap<CR>


" TODO too many TERM is opened
" TODO icycle/helm like buffer replacing
" TODO 24bit color tmux
" delete all audocmd with default group
autocmd!

set hidden
set history=100

" et ts sts sw
set expandtab tabstop=4 softtabstop=4 shiftwidth=4
set nowrap
set hlsearch
set incsearch

set showmatch
set showcmd

set noeol
set nofixeol

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

nnoremap <leader>q :qa!<CR>
" for 'edit previous file'
nnoremap <leader><leader> :e#<CR>

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

" :PlugInstall
call plug#begin("~/.vim/plugged")
Plug 'Shougo/denite.nvim'
" Plug 'dracula/vim'
" Plug 'rafi/awesome-vim-colorschemes'
Plug 'arcticicestudio/nord-vim'
" Plug 'blueyed/vim-diminactive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" colorscheme dracula
colorscheme nord

hi StatusLine   ctermfg=15  guifg=#ffffff ctermbg=239 guibg=#949031 cterm=bold gui=bold
hi StatusLineNC ctermfg=249 guifg=#b2b2b2 ctermbg=237 guibg=#3a3a3a cterm=none gui=none

if (has("termguicolors"))
 set termguicolors
endif

set splitright
inoremap <C-g> <Esc>

nnoremap <Leader>ve :e $MYVIMRC<CR>
nnoremap <Leader>vr :source $MYVIMRC<CR>

" for 'edit previous file'
nnoremap <leader><leader> :e#<CR>


if has('nvim')
  " Terminal setting
  " Esc/C-g for exit to normal mode
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-v><Esc> <Esc>
  tnoremap <C-g> <C-\><C-n>
  tnoremap <C-v><C-g> <C-g>
  nnoremap <leader>t :vs term://$SHELL<CR>:set number!<CR>i

  noremap <C-o> <C-w>w
  tnoremap <silent> <C-o> <C-\><C-n>:let w:twasimode=1<CR><C-w>w
  augroup TerminalFocusSetImode
    autocmd!
    autocmd WinEnter *
        \ if exists("w:twasimode")
        \ | unlet w:twasimode
        \ | execute "normal! a"
        \ | endif
  augroup END
endif

" https://github.com/neovim/neovim/wiki/FAQ
" http://vimcasts.org/episodes/show-invisibles/
nmap <leader>l :set list!<CR>:set number!<CR>:set wrap!<CR>
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

" from https://raw.githubusercontent.com/ctaylo21/jarvis/master/config/nvim/init.vim
" === Denite setup ==="
try
" Use ripgrep for searching current directory for files
" By default, ripgrep will respect rules in .gitignore
"   --files: Print each file that would be searched (but don't search)
"   --glob:  Include or exclues files for searching that match the given glob
"            (aka ignore .git files)
"
call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])

" Use ripgrep in place of "grep"
call denite#custom#var('grep', 'command', ['rg'])

" Custom options for ripgrep
"   --vimgrep:  Show results with every match on it's own line
"   --hidden:   Search hidden directories and files
"   --heading:  Show the file name above clusters of matches from each file
"   --S:        Search case insensitively if the pattern is all lowercase
call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])

" Recommended defaults for ripgrep via Denite docs
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Remove date from buffer list
call denite#custom#var('buffer', 'date_format', '')

" Custom options for Denite
"   auto_resize             - Auto resize the Denite window height automatically.
"   prompt                  - Customize denite prompt
"   direction               - Specify Denite window direction as directly below current pane
"   winminheight            - Specify min height for Denite window
"   highlight_mode_insert   - Specify h1-CursorLine in insert mode
"   prompt_highlight        - Specify color of prompt
"   highlight_matched_char  - Matched characters highlight
"   highlight_matched_range - matched range highlight
let s:denite_options = {'default' : {
\ 'split': 'floating',
\ 'start_filter': 1,
\ 'auto_resize': 1,
\ 'source_names': 'short',
\ 'prompt': 'λ ',
\ 'highlight_matched_char': 'QuickFixLine',
\ 'highlight_matched_range': 'Visual',
\ 'highlight_window_background': 'Visual',
\ 'highlight_filter_background': 'DiffAdd',
\ 'winrow': 1,
\ 'vertical_preview': 1
\ }}

" Loop through denite options and enable them
function! s:profile(opts) abort
  for l:fname in keys(a:opts)
    for l:dopt in keys(a:opts[l:fname])
      call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
    endfor
  endfor
endfunction

call s:profile(s:denite_options)
catch
    echo 'Denite not installed. It should work after running :PlugInstall'
endtry

" === Denite shorcuts === "
"   <leader>b - Browser currently open buffers
"   <leader>f - Browse list of files in current directory
"   <leader>g - Search current directory for occurences of given term and close window if no results
"   <leader>j - Search current directory for occurences of word under cursor
nmap <leader>b :Denite buffer -split=floating -winrow=1<CR>
nmap <leader>f :DeniteProjectDir file/rec -split=botthm<CR>
nnoremap <leader>g :<C-u>Denite grep:. -no-empty<CR>
nnoremap <leader>j :<C-u>DeniteCursorWord grep:.<CR>

" Define mappings while in 'filter' mode
"   <C-o>         - Switch to normal mode inside of search results
"   <Esc>         - Exit denite window in any mode
"   <CR>          - Open currently selected file in any mode
"   <C-t>         - Open currently selected file in a new tab
"   <C-v>         - Open currently selected file a vertical split
"   <C-h>         - Open currently selected file in a horizontal split
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-o>
  \ <Plug>(denite_filter_quit)
  inoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  inoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  inoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  inoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  inoremap <silent><buffer><expr> <C-h>
  \ denite#do_map('do_action', 'split')
endfunction

" Define mappings while in denite window
"   <CR>        - Opens currently selected file
"   q or <Esc>  - Quit Denite window
"   d           - Delete currenly selected file
"   p           - Preview currently selected file
"   <C-o> or i  - Switch to insert mode inside of filter prompt
"   <C-t>       - Open currently selected file in a new tab
"   <C-v>       - Open currently selected file a vertical split
"   <C-h>       - Open currently selected file in a horizontal split
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-o>
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  nnoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> <C-h>
  \ denite#do_map('do_action', 'split')
endfunction

" TODO too many TERM is opened
" TODO icycle/helm like buffer replacing
" TODO 24bit color tmux
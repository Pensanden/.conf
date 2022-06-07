set noerrorbells
set scrolloff=8
set number 
set relativenumber
set noswapfile
set encoding=UTF-8
set belloff=all
set nowritebackup
set termguicolors

syntax on

call plug#begin()

"Folders and Apearence"

Plug 'ayu-theme/ayu-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'Yggdroot/indentLine'
Plug 'preservim/nerdtree'
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin' |
            \ Plug 'ryanoasis/vim-devicons'


"Auto-Complete and language Servers"

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do' : { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'OmniSharp/omnisharp-vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'


"Python"
Plug 'vim-scripts/indentpython.vim'
Plug 'vim-syntastic/syntastic'
Plug 'nvie/vim-flake8'
Plug 'tweekmonster/django-plus.vim'


call plug#end()

colorscheme gruvbox

"Airline Configurations"
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_right_sep = ""
let g:airline_left_sep = ""


let mapleader = " "

"Control-P"
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

nnoremap <leader><CR> :so ~/.vimrc<CR>

"NERDTree Configurations"

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

"Auto run NT
autocmd VimEnter *  NERDTree | wincmd p

"Enter NT if no file is specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

let g:NERDTreeGitStatusIndicatorMapCustom = {
	                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }

let g:NERDTreeGitStatusUseNerdFonts = 1


let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_setColors = 1 

"LSP Shortcuts

nnoremap <leader>d :LspHover<CR>
nnoremap <F2> :LspRename<CR>
nnoremap <C-K> :LspNextError<CR>
"OmniSharp Configurations
"Show type information automatically when the cursor stops moving.
"Note that the type is echoed to the Vim command line, and will overwrite
"any other messages in this space including e.g. ALE linting messages.

autocmd FileType cs  nnoremap <leader>d :OmniSharpDocumentation<CR>
autocmd FileType cs  nnoremap <C-]>  :OmniSharpFindImplementations<CR>

nnoremap  <C-.> :CocAction<CR>

" Asyncomplete: {{{
 let g:asyncomplete_auto_popup = 1
 let g:asyncomplete_auto_completeopt = 1
 " }}}
 
" OmniSharp: {{{
let g:OmniSharp_popup_position = 'peek'
if has('nvim')
  let g:OmniSharp_popup_options = {
  \ 'winhl': 'Normal:NormalFloat'
  \}
else
    let g:OmniSharp_popup_options = {
    \ 'highlight': 'Normal',
    \ 'padding': [0, 0, 0, 0],
    \ 'border': [1]
    \}
endif
let g:OmniSharp_popup_mappings = {
\ 'sigNext': '<C-n>',
\ 'sigPrev': '<C-p>',
\ 'pageDown': ['<C-f>', '<PageDown>'],
\ 'pageUp': ['<C-b>', '<PageUp>']
\}
"if s:using_snippets
"	let g:OmniSharp_want_snippet = 1
"endif

let g:OmniSharp_highlight_groups = {
\ 'ExcludedCode': 'NonText'
\}
" }}}


"PHP"

au User lsp_setup call lsp#register_server({
    \ 'name': 'php',
    \ 'cmd': {server_info->['php', expand('~/.vim/bundle/php-language-server/bin/php-language-server.php')]},
    \ 'whitelist': ['php'],
    \ })

"PEP8 Compliance Configurations"
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix
"Unnecessary Whitespace Flag"
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

"Virtual Enviroment Support"
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

"Python Config"
let python_highlight_all=1
let NERDTreeIgnore=['\.pyc$', '\~$'] 
syntax on

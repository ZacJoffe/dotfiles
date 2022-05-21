" Plugins will be downloaded under the specified directory.
call plug#begin('~/.local/share/nvim/plugged')
" Declare the list of plugins.
Plug 'itchyny/lightline.vim'
Plug 'lervag/vimtex'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'bkad/CamelCaseMotion'
Plug 'jiangmiao/auto-pairs'
Plug 'psliwka/vim-smoothie'
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
"Plug 'christoomey/vim-tmux-navigator'
Plug 'arcticicestudio/nord-vim'
Plug 'mbbill/undotree'
Plug 'machakann/vim-sandwich'
Plug 'rbgrouleff/bclose.vim' " dependency for ranger
Plug 'francoiscabrol/ranger.vim'
Plug 'tpope/vim-fugitive'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

set number
set encoding=utf-8
set laststatus=2
set tabstop=4
set shiftwidth=4
set expandtab
set linebreak
set clipboard=unnamedplus
set ignorecase
set smartcase
"set termguicolors
set notermguicolors
set wrap!

syntax on
colorscheme nord
let g:lightline = {'colorscheme': 'nord'}

let g:tex_flavor='latex'
let g:vimtex_view_general_viewer = 'evince'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats='pdf, aux'
let g:Tex_ViewRule_pdf='evince 2>/dev/null'
" let g:vimtex_view_method='zathura'
" let g:vimtex_view_method='evince'

" remap leader key to space
map <Space> <Leader>

" set text wrapping and spell check when loading tex/md files
autocmd BufRead,BufNewFile *.tex
      \ setlocal spell | setlocal wrap! | setlocal iskeyword-={}[] | setlocal ts=2 sts=2 sw=2

autocmd BufRead,BufNewFile *.md
      \ setlocal spell | setlocal wrap! | setlocal iskeyword-={}[] | setlocal ts=2 sts=2 sw=2


call camelcasemotion#CreateMotionMappings('<leader>')

" add angled brackets to match pairs (so I can use % to jump between them)
set matchpairs+=<:>

" let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''", '<':'>'}
let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}



" treat soft wraps as different lines
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
" nnoremap <expr> $ v:count ? '$' : 'g$'
" nnoremap <expr> 0 v:count ? '0' : 'g0'

" fzf
nnoremap <Leader>bf :GFiles<CR>
nnoremap <Leader>bF :Files<CR>
nnoremap <Leader><Space> :Buffers<CR>

" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0

" tmux zoom like feature for vim windows
nmap <C-W><C-O> <Plug>(zoom-toggle)

let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1

" tmux mouse scrolling
set mouse=a

" navigate vim splits with the 
" let g:tmux_navigator_no_mappings = 1
" nnoremap <silent> <C-w>h :TmuxNavigateLeft<cr>
" nnoremap <silent> <C-w>j :TmuxNavigateDown<cr>
" nnoremap <silent> <C-w>k :TmuxNavigateUp<cr>
" nnoremap <silent> <C-w>l :TmuxNavigateRight<cr>

set number relativenumber

" :augroup numbertoggle
" :  autocmd!
" :  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
" :  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
" :augroup END


" vim repeat setup
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

" return word count for latex document or any other opened file
function! WC()
    let filename = expand("%")
    let extension = expand('%:e')
    if extension==".tex"
        let cmd = "detex " . filename . " | wc -w | tr -d [:space:]"
        let result = system(cmd)
        echo result . " words"
    else
        let cmd = "wc -w " . filename . " | sed 's/\\s.*$//' | tr -d [:space:]"
        let result = system(cmd)
        echo result . " words"
    endif
endfunction

" move right one character
inoremap <C-e> <Right>

" C-c for escape
nmap <C-c> <esc>
imap <C-c> <esc>
vmap <C-c> <esc>
omap <C-c> <esc>

command WC call WC()

set nocompatible
filetype plugin on

" do not clear clipboard on exit
autocmd VimLeave * call system("xsel -ib", getreg('+'))

" disable line numbers in :term and ranger
augroup TerminalStuff
  au!
  autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

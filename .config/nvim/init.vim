" Plugins will be downloaded under the specified directory.
call plug#begin('~/.local/share/nvim/plugged')

" Declare the list of plugins.
Plug 'chrisbra/unicode.vim'
Plug 'itchyny/lightline.vim'
Plug 'lervag/vimtex'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'justinmk/vim-sneak'
Plug 'bkad/CamelCaseMotion'
Plug 'jiangmiao/auto-pairs'
Plug 'psliwka/vim-smoothie'
Plug 'mg979/vim-visual-multi'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'dhruvasagar/vim-zoom'
Plug 'fatih/vim-go'
Plug 'rust-lang/rust.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'arcticicestudio/nord-vim'
Plug 'mbbill/undotree'
Plug 'machakann/vim-sandwich'
Plug 'rbgrouleff/bclose.vim' " dependency for ranger
Plug 'francoiscabrol/ranger.vim'
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
set termguicolors
set wrap!

syntax on
set background=dark
colorscheme nord
let g:lightline = {'colorscheme': 'nord'}

let g:tex_flavor='latex'
let g:vimtex_view_general_viewer = 'evince'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats='pdf, aux'
let g:Tex_ViewRule_pdf='evince 2>/dev/null'
" let g:vimtex_view_method='zathura'
" let g:vimtex_view_method='evince'

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

""" COC """

function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

" Use C to open coc config
call SetupCommandAbbrs('C', 'CocConfig')

" nmap <silent> <leader>dd <Plug>(coc-definition)
" nmap <silent> <leader>dr <Plug>(coc-references)
" nmap <silent> <leader>dj <Plug>(coc-implementation)

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
" set signcolumn=yes

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" if autocomplete menu is open, select option with tab
"
" otherwise, escape a bunch of characters using tab
" the syntax is black magic, as far as I can tell this works for the following
" chars:
" "[", "]", "<", ">", "(", ")", "{", "}", ";", "'", "\"", "$"
"inoremap <expr> <Tab> search('\%#[][<>(){};''"`]', 'n') ? '<Right>' : '<Tab>'
inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : search('\%#[][<>(){};''"`$]', 'n') ? '<Right>' : '<Tab>'

" treat soft wraps as different lines
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
" nnoremap <expr> $ v:count ? '$' : 'g$'
" nnoremap <expr> 0 v:count ? '0' : 'g0'

" fzf
"nnoremap <silent> ; :Files<cr>
"nnoremap <silent> <M-z> :Buffers<cr>
nmap <leader><tab> <Plug>(fzf-maps-n)
imap <leader><tab> <Plug>(fzf-maps-i)
xmap <leader><tab> <Plug>(fzf-maps-x)
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

:set number relativenumber

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END


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

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.local/share/nvim/plugged')

" Declare the list of plugins.
Plug 'itchyny/lightline.vim'
Plug 'lervag/vimtex'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'justinmk/vim-sneak'
Plug 'bkad/CamelCaseMotion'
Plug 'jiangmiao/auto-pairs'
Plug 'psliwka/vim-smoothie'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'fatih/vim-go'
Plug 'rust-lang/rust.vim'
"Plug 'christoomey/vim-tmux-navigator'
Plug 'arcticicestudio/nord-vim'
Plug 'mbbill/undotree'
Plug 'machakann/vim-sandwich'
Plug 'rbgrouleff/bclose.vim' " dependency for ranger
Plug 'francoiscabrol/ranger.vim'
Plug 'tpope/vim-fugitive'
Plug 'antoinemadec/coc-fzf'
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

""" COC """
"autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
"inoremap <silent> <C-o> :call CocActionAsync('showSignatureHelp')<cr>
"
let g:coc_snippet_next = '<tab>'

function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Use C to open coc config
call SetupCommandAbbrs('C', 'CocConfig')

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" coc extensions
let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-snippets', 'coc-clangd', 'coc-go', 'coc-python', 'coc-rls']
"
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" if autocomplete menu is open, select option with tab
"
" otherwise, escape a bunch of characters using tab
" the syntax is black magic, as far as I can tell this works for the following
" chars:
" "[", "]", "<", ">", "(", ")", "{", "}", ";", "'", "\"", "$"
"inoremap <expr> <Tab> search('\%#[][<>(){};''"`]', 'n') ? '<Right>' : '<Tab>'
inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : search('\%#[][<>(){};''"`$]', 'n') ? '<Right>' : '<Tab>'

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}



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

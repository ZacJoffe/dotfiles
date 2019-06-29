" Plugins will be downloaded under the specified directory.
call plug#begin('~/.local/share/nvim/plugged')

" Declare the list of plugins.
Plug 'chrisbra/unicode.vim'
Plug 'itchyny/lightline.vim'
Plug 'w0rp/ale'
Plug 'lervag/vimtex'
Plug 'liuchengxu/space-vim-dark'
Plug 'morhetz/gruvbox'
Plug 'gabrielelana/vim-markdown'
Plug 'scrooloose/nerdtree'
Plug 'dylanaraps/wal.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'justinmk/vim-sneak'
Plug 'bkad/CamelCaseMotion'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

set number
set encoding=utf-8
set laststatus=2
set tabstop=4
set shiftwidth=4
set linebreak
set clipboard=unnamedplus
set ignorecase
set smartcase
"set termguicolors

syntax on

"colorscheme gruvbox
colorscheme wal
"set bg=dark

let g:lightline = {'colorscheme': 'wal'}

let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats='pdf, aux'
let g:Tex_ViewRule_pdf='evince 2>/dev/null'
let g:vimtex_view_method='zathura'

"let g:deoplete#enable_at_startup = 1

map <silent> <C-n> :NERDTreeToggle<CR>

call camelcasemotion#CreateMotionMappings('<leader>')

" map <silent> w <Plug>CamelCaseMotion_w
" map <silent> b <Plug>CamelCaseMotion_b
" map <silent> e <Plug>CamelCaseMotion_e

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

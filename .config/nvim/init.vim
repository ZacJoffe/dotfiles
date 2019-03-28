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
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

set number
set encoding=utf-8
set laststatus=2
set tabstop=4
set shiftwidth=4
set linebreak
set clipboard=unnamedplus
set termguicolors

syntax on

colorscheme gruvbox
set bg=dark

let g:lightline = {'colorscheme': 'gruvbox'}

let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats='pdf, aux'
let g:Tex_ViewRule_pdf='evince 2>/dev/null'
let g:vimtex_view_method='zathura'

let g:deoplete#enable_at_startup = 1

map <silent> <C-n> :NERDTreeToggle<CR>

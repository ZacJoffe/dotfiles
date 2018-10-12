" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'chrisbra/unicode.vim'
Plug 'itchyny/lightline.vim'
Plug 'w0rp/ale'
Plug 'vim-latex/vim-latex'
Plug 'liuchengxu/space-vim-dark'
Plug 'morhetz/gruvbox'
Plug 'gabrielelana/vim-markdown'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

set number
set encoding=utf-8
set laststatus=2
set tabstop=4
set shiftwidth=4
set linebreak
set clipboard=unnamedplus

syntax on

let g:tex_flavor='latex'
let g:lightline = {'colorscheme': 'wombat'}

let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats='pdf, aux'
let g:Tex_ViewRule_pdf='evince 2>/dev/null'

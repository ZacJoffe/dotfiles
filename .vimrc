" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'chrisbra/unicode.vim'
Plug 'itchyny/lightline.vim'
Plug 'w0rp/ale'
Plug 'vim-latex/vim-latex'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

set number
set encoding=utf-8
set laststatus=2

let g:tex_flavor='latex'
let g:lightline = {'colorscheme': 'wombat'}

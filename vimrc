" Turn on line numbers
set number

" Turn on syntax highlighting
syntax on

" Use the system clipboard for yank / delete / paste operations 
set clipboard=unnamedplus

" MIGHTY MOUSE!!
set mouse=a

" Tab navigation with ctrl modifier
map  <C-l> :tabn<CR>
map  <C-h> :tabp<CR>
map  <C-n> :tabnew<CR>


filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=2
" when indenting with '>', use 4 spaces width
set shiftwidth=2
" On pressing tab, insert 4 spaces
set expandtab

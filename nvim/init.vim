call plug#begin()

" Extendable fuzzy finder over lists & project concept
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.2' }
Plug 'nvim-telescope/telescope-project.nvim'

Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'
Plug 'Townk/vim-autoclose'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'ngmy/vim-rubocop'

Plug 'vim-airline/vim-airline'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'ntpeters/vim-better-whitespace'

Plug 'morhetz/gruvbox'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'vim-test/vim-test'

Plug 'mhinz/vim-startify'

Plug 'TimUntersberger/neogit'
Plug 'knsh14/vim-github-link'
Plug 'github/copilot.vim'

Plug 'jparise/vim-graphql'

call plug#end()

" Enable Ruler
set ru
" Show the line number
set number
" Enable using the mouse to click or select some peace of code
set mouse=a
" Set the Tab to 2 spaces
set tabstop=2
set shiftwidth=2

autocmd vimenter * ++nested colorscheme gruvbox

let mapleader="\<space>"

" Save current file
noremap <leader>s :w<cr>

" Close current split
noremap <leader>w <C-w>c

" Navigate splits like vim hjkl
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

" Terminal mappings
tnoremap <Esc> <C-\><C-n> " Use esc to exit terminal mode

" Better navigation at terminal mode
tnoremap <leader>h <C-w>h
tnoremap <leader>j <C-w>j
tnoremap <leader>k <C-w>k
tnoremap <leader>l <C-w>l

" Find files using Telescope command-line sugar.
nnoremap <leader>pp <cmd>Telescope project<cr>
nnoremap <leader>pf <cmd>Telescope find_files<cr>
nnoremap <leader>pg <cmd>Telescope live_grep<cr>
nnoremap <leader>pb <cmd>Telescope buffers<cr>
nnoremap <leader>ph <cmd>Telescope help_tags<cr>

" Tests shortcuts
nmap <silent> <leader>tn <cmd>TestNearest<cr>
nmap <silent> <leader>tf <cmd>TestFile<cr>
nmap <silent> <leader>tl <cmd>TestLast<cr>
nmap <silent> <leader>tg <cmd>TestVisit<cr>

let g:startify_bookmarks = [ {'vimrc': '~/.config/nvim/init.vim'}, { 'zshrc': '~/.zshrc' } ]

" To enable stripping whitespace on save
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

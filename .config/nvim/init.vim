" +---------------------------------------------+
" |                                             |
" | GLOBAL SETTING                              |
" |                                             |
" +---------------------------------------------+

" Color scheme setup
syntax on
" colorscheme onedark
" colorscheme gruvbox
colorscheme onedarkpro
" colorscheme material
" let g:material_style = "darker"
" colorscheme codedark
set background=dark

" enable mouse support
set mouse=a

" Indent stuff
set expandtab
set smarttab
set smartindent
set nowrap
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Line numbering
set relativenumber
set number

" Searching stuff
set smartcase
set ignorecase
set incsearch
set nohlsearch

" Undo stuff
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.vim/undodir
set undofile

set scrolloff=8
set cmdheight=1

set hidden
set noerrorbells

"set to ~80 if to enable it
set colorcolumn=0

" Spell checking and custom spell file
set nospell
set spelllang=en,de
set spellfile=$HOME/neovim/spellfile/en.utf-8.add

" global statusline
set laststatus=3

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=150

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  "set signcolumn=number
  set signcolumn=yes
else
  set signcolumn=yes
endif


" +---------------------------------------------+
" |                                             |
" | KEY MAPPINGS                                |
" |                                             |
" +---------------------------------------------+

imap jk <Esc>
let mapleader = " "

" Open vim RC with leader v
nnoremap <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>ep :e ~/.config/nvim/plugin/plugins.lua<CR>
nnoremap <leader>el :e ~/.config/nvim/plugin/lsp-config.lua<CR>
nnoremap <leader>ez :e ~/.zshrc<CR>
nnoremap <leader>et :e ~/.tmux.conf<CR>
nnoremap <leader>rv :source $MYVIMRC<CR>

nnoremap <leader>p :lua require"nvim-helloworld"<CR>
" save with c-s
"nnoremap <c-s> :w<CR>
"inoremap <c-s> <ESC>:w<CR>i
nnoremap <leader>w :w<CR>

" Copilot settings
map <leader>cp :Copilot panel<CR>
map <leader>ce :Copilot enable<CR>
map <leader>cd :Copilot disable<CR>

" close with c-w
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :q!<CR>
"nnoremap <c-w> :q<CR>
"inoremap <c-w> <ESC>:q<CR>
" User leader j to insert line below and stay in normal
" nnoremap <leader>j <CR>

nnoremap <leader>b :TransparentToggle<CR>

" enable termguicolors if available
if (has("termguicolors"))
  set termguicolors
endif

" szw/vim-maximizer
nnoremap <leader>m :MaximizerToggle!<CR>

" kassio/neoterm
let g:neoterm_default_mod = 'vertical'
let g:neoterm_size = 12
let g:neoterm_default_mod = 'botright'
let g:neoterm_autoinsert = 1
nnoremap <c-n> :Ttoggle<CR>
inoremap <c-n> <Esc>:Ttoggle<CR>
tnoremap <c-n> <c-\><c-n>:Ttoggle<CR>

" Trimming white space on save
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

" Auto commands
augroup JONA_WESSENDORF
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END


" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" TELESCOPE STUFF

lua require('telescope').setup{ defaults = { files_sorter = require('telescope.sorters').get_fzy_sorter }, extensions = { fzy_native = { override_generic_sorter = false, override_file_sorter = true, } } }

lua require('telescope').load_extension('fzy_native')

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <C-p> <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>


" Git Fugitive remaps

"nmap <leader>gf :diffget //3<CR>
"nmap <leader>gj :diffget //2<CR>
"nmap <leader>gs :G<CR>
nmap <leader>gs :G<CR>

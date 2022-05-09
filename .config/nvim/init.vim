" +---------------------------------------------+
" |                                             |
" | PLUGINS                                     |
" |                                             |
" +---------------------------------------------+
call plug#begin(stdpath('data') . '/plugged')
" Color theme
" Plug 'gruvbox-community/gruvbox'
Plug 'morhetz/gruvbox'
" Plug 'joshdick/onedark.vim'
" Plug 'tomasiser/vim-code-dark'


" C support
Plug 'jackguo380/vim-lsp-cxx-highlight'

" status line plugin
"Plug 'itchyny/lightline.vim'
"Plug 'itchyny/vim-gitbranch'

Plug 'szw/vim-maximizer'
Plug 'kassio/neoterm'

Plug 'xiyaowong/nvim-transparent'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" Tresitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

" Vim surround plugin
Plug 'tpope/vim-surround'

" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" tmux vim navitation
Plug 'christoomey/vim-tmux-navigator'

" Formatter
Plug 'sbdchd/neoformat'

" Git plugins
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'

" JS/TS Plugins
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

"
Plug 'ThePrimeagen/vim-be-good'


call plug#end()

" +---------------------------------------------+
" |                                             |
" | GLOBAL SETTING                              |
" |                                             |
" +---------------------------------------------+

" Color scheme setup
syntax on
" colorscheme onedark
colorscheme gruvbox
" colorscheme codedark
set background=dark

" enable mouse support
set mouse=a

" RAMAP REMAP? C-i and C-o to C-j and C-K
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
set spell
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
nnoremap <leader>ez :e ~/.zshrc<CR>
nnoremap <leader>et :e ~/.tmux.conf<CR>
nnoremap <leader>rv :source $MYVIMRC<CR>

nnoremap <leader>p :lua require"nvim-helloworld"<CR>
" save with c-s
"nnoremap <c-s> :w<CR>
"inoremap <c-s> <ESC>:w<CR>i
nnoremap <leader>w :w<CR>

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


" coc config
let g:coc_global_extensions = [
  \ 'coc-eslint',
  \ 'coc-json',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ ]

"  \ 'coc-prettier',
"  \ 'coc-snippets',

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

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)


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

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end


" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
" commented out
" nmap <silent> <C-s> <Plug>(coc-range-select)
" xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
"nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>



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

" JumpTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
"nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.

"nmap <leader>qf  <Plug>(coc-fix-current)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Symbol renaming.
nmap <F2> <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>fs  <Plug>(coc-format-selected)
nmap <leader>fs <Plug>(coc-format-selected)



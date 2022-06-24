-- vim:fileencoding=utf-8:foldmethod=marker

-- General {{{

local opt = vim.opt

vim.g.mapleader = ' '

opt.mouse = 'a'

opt.termguicolors = true
vim.o.background = 'dark'


opt.relativenumber = true

opt.ignorecase = true
opt.smartcase = true

opt.updatetime = 50

opt.expandtab = true
opt.smarttab = true
opt.smartindent = true
opt.wrap = false
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.undodir = '$HOME/.vim/undodir'
opt.undofile = true

opt.scrolloff = 6
opt.cmdheight = 1
opt.shortmess:append('c')
opt.colorcolumn = '80'
opt.signcolumn = "yes:2"
--opt.signcolumn = 'auto:2-5'

opt.spell = false
opt.spelllang = 'en,de'
opt.spellfile = '$HOME/neovim/spellfile/en.utf-8.add'


-- }}}


-- Plugnin {{{

-- setup packer if it is not installed
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end


require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    -- Color theme
    use {
        'olimorris/onedarkpro.nvim',
        config = function ()
            -- vim.g.colors_name = ''
            require('onedarkpro').load()
        end,
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function()
            require('lualine').setup()
        end,
    }

    -- Telescope
    -- use ´:checkhealth telescope´ after installation to check if everithing is set up correctly
    use {
        'nvim-telescope/telescope.nvim',

        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('telescope').setup({
                defaults = {
                    files_sorter = require('telescope.sorters').get_fzy_sorter
                },
                extensions = {
                    fzy_native = { override_generic_sorter = false, override_file_sorter = true, }
                },
            })
            require('telescope').load_extension('fzy_native')
        end,
    }
    use {
        'nvim-telescope/telescope-fzy-native.nvim',
        run = 'make'
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    -- lsp default config
    use {
        'williamboman/nvim-lsp-installer',
        'neovim/nvim-lspconfig'
    }

    -- autocomplete
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip' -- Snippets plugin

    use 'tpope/vim-surround' -- motions for ", ' and html tags
    use 'tpope/vim-commentary' -- comment out code
    --use 'github/copilot.vim'

    -- tmux vim navitation
    use 'christoomey/vim-tmux-navigator'

    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup({}) end
    }

    use {
        'windwp/nvim-ts-autotag',
        config = function() require('nvim-ts-autotag').setup() end
    }

    -- Formatter
    --use 'sbdchd/neoformat'

    -- Git plugins
    --use 'tpope/vim-fugitive'
    --use 'vim-airline/vim-airline'
    --use 'airblade/vim-gitgutter'
    use {
        'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function ()
            require('gitsigns').setup()
        end
    }

    --use 'RRethy/vim-illuminate' -- highlight the current word


    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)

-- }}}


-- Treesitter {{{
require('nvim-treesitter.configs').setup({
    ensure_installed = {
        'bash',
        'c',
        'cmake',
        'comment',
        'css',
        'dockerfile',
        'go',
        'help',
        'json',
        'jsonc',
        'latex',
        'lua',
        'prisma',
        'python',
        'regex',
        'rust',
        'scss',
        'svelte',
        'toml',
        'tsx',
        'vim',
        'vue',
        'yaml',
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indend = {
        enable = true,
    },
    autotag = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
})
--vim.opt.foldmethod = 'expr'
--vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- }}}


-- LSP Setup {{{

require('nvim-lsp-installer').setup({
    automatic_installation = true,
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
--vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
--vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  --vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

local lsp_flags = {
  debounce_text_changes = 150,
}

local lspconfig = require('lspconfig')

lspconfig.pyright.setup({
    on_attach = on_attach,
    flags = lsp_flags,
})
lspconfig.clangd.setup({
    on_attach = on_attach,
    flags = lsp_flags,
})
lspconfig.volar.setup({
    on_attach = on_attach,
    flags = lsp_flags,
})
lspconfig.sumneko_lua.setup({
    on_attach = on_attach,
    flags = lsp_flags,
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim', 'use' }
            },
        }
    }
})
lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
    flags = lsp_flags,
})
lspconfig.jdtls.setup({
    on_attach = on_attach,
    flags = lsp_flags,
})
lspconfig.tsserver.setup({
    on_attach = on_attach,
    flags = lsp_flags,
})
lspconfig.tailwindcss.setup({
    on_attach = on_attach,
    flags = lsp_flags,
})
lspconfig.eslint.setup({
    on_attach = on_attach,
    flags = lsp_flags,
})
lspconfig.cssmodules_ls.setup({
    on_attach = on_attach,
    flags = lsp_flags,
})

-- }}}


-- Autocomplete {{{

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

-- luasnip setup
-- local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- }}}


-- Keymaps {{{

local opts = { noremap = true }
local keymap = vim.api.nvim_set_keymap
local keymapno = function(keybind, action)
    keymap('n', keybind, action, opts)
end

keymap('i', 'jk', '<Esc>', opts)

keymapno('<leader>w', ':w<CR>')
keymapno('<leader>W', ':wq<CR>')
keymapno('<leader>q', ':q<CR>')
keymapno('<leader>Q', ':q!<CR>')


-- editing and realoading configs
keymapno('<leader>ev', ':e $MYVIMRC<CR>')
keymapno('<leader>ez', ':e $HOME/.zshrc<CR>')
keymapno('<leader>et', ':e $HOME/.tmux.conf<CR>')
keymapno('<leader>rv', ':source $MYVIMRC<CR>')
keymapno('<leader>rp', ':PackerSync<CR>')

-- Telescope
keymapno('<leader>ff', '<cmd> Telescope find_files<cr>')
keymapno('<C-p>', '<cmd> Telescope git_files<cr>')
keymapno('<leader>fg', '<cmd> Telescope live_grep<cr>')
keymapno('<leader>fb', '<cmd> Telescope buffers<cr>')
keymapno('<leader>fh', '<cmd> Telescope help_tags<cr>')
keymapno('<leader>fm', '<cmd> Telescope man_pages<cr>')

-- }}}

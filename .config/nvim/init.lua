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

opt.laststatus = 3

opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
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
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
        install_path })
end


require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    -- Color theme
    use {
        'olimorris/onedarkpro.nvim',
        config = function()
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

    use {
        "glepnir/lspsaga.nvim",
        branch = "main",
        config = function()
            local saga = require("lspsaga")

            saga.init_lsp_saga({
                code_action_lightbulb = {
                    virtual_text = true,
                },
                code_action_keys = {
                    quit = "<Esc>",
                    exec = "<CR>",
                },
                finder_action_keys = {
                    open = "o",
                    vsplit = "v",
                    split = "s",
                    quit = "<Esc>",
                    scroll_down = "<C-f>",
                    scroll_up = "<C-b>",
                },
                move_in_saga = { prev = 'k',next = 'j'},
                rename_action_quit = "<C-c>",
                code_action_icon = "",
                max_preview_lines = 15,
            })
        end,
    }

    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'
    use 'theHamsta/nvim-dap-virtual-text'


    use {
        'JoosepAlviste/nvim-ts-context-commentstring',
        config = function()
            require'nvim-treesitter.configs'.setup {
                context_commentstring = {
                    enable = true
                }
            }
        end
    }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup({
                toggler = {
                    line = 'gcc',
                    block = 'gbc',
                },
                opleader = {
                    line = 'gc',
                    block = 'gb',
                },
                extra = {
                    above = 'gcO',
                    below = 'gco',
                    eol = 'gcA',
                },
                mappings = {
                    basic = true,
                    extra = true,
                    extended = false,
                },
                pre_hook = function(ctx)
                    -- Only calculate commentstring for tsx filetypes
                    if vim.bo.filetype == 'typescriptreact' then
                        local U = require('Comment.utils')

                        -- Determine whether to use linewise or blockwise commentstring
                        local type = ctx.ctype == U.ctype.line and '__default' or '__multiline'

                        -- Determine the location where to calculate commentstring from
                        local location = nil
                        if ctx.ctype == U.ctype.block then
                            location = require('ts_context_commentstring.utils').get_cursor_location()
                        elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
                            location = require('ts_context_commentstring.utils').get_visual_start_location()
                        end

                        return require('ts_context_commentstring.internal').calculate_commentstring({
                            key = type,
                            location = location,
                        })
                    end
                end,
            })
            vim.api.nvim_set_keymap('n', '<C-_>', 'gcc', { noremap = true })
            vim.api.nvim_set_keymap('v', '<C-_>', 'gb', { noremap = true })
        end
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
    use 'github/copilot.vim'

    use {
        'norcalli/nvim-colorizer.lua',
        config = function() 
            require('colorizer').setup()
        end
    }

    use {
        'TimUntersberger/neogit',
        requires = {'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim'},
        config = function ()
            local neogit = require('neogit')
            neogit.setup({
                integrations = {
                    diffview = true
                }
            })
            vim.api.nvim_set_keymap('n', '<C-g>', ':Neogit<CR>', { noremap = true })
        end
    }


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

    use {
        'akinsho/bufferline.nvim',
        tag = "v2.*",
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require("bufferline").setup({
                options = {
                    diagnostics = "nvim_lsp",
                    diagnostics_indicator = function(count, level, _, _)
                        local icon = level:match("error") and " " or " "
                        return " " .. icon .. count
                    end,
                    right_mouse_command = "vertical sbuffer %d"
                }
            })
        end
    }

    use {
        "akinsho/toggleterm.nvim",
        tag = 'v1.*',
        config = function()
            require("toggleterm").setup({})
            function _G.set_terminal_keymaps()
                local opts = { noremap = true }
                vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
                vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
                --vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
                --vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
                --vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
                --vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
            end

            vim.api.nvim_set_keymap('n', '<C-n>', ':ToggleTerm direction=horizontal size=17<CR>', { noremap = true })
            vim.api.nvim_set_keymap('t', '<C-n>', '<C-\\><C-n>:ToggleTerm<CR>', { noremap = true })
            vim.api.nvim_set_keymap('i', '<C-n>', '<esc>:ToggleTerm direction=horizontal size=17<CR>', { noremap = true })

            -- if you only want these mappings for toggle term use term://*toggleterm#* instead
            vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
        end
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
        config = function()
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
        'typescript',
        'javascript',
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


-- LSP and Autocomplete Setup {{{

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
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>of', vim.diagnostic.open_float, opts)
vim.keymap.set("n", "<leader>dp", require("lspsaga.diagnostic").goto_prev, opts)
vim.keymap.set("n", "<leader>dn", require("lspsaga.diagnostic").goto_next, opts)

vim.keymap.set('n', '<space>ol', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    --vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'K', require('lspsaga.hover').render_hover_doc, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    --vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    --vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    --vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    --vim.keymap.set('n', '<space>wl', function()
    --  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    --end, bufopts)
    vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition, bufopts)

    --vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>rn', require('lspsaga.rename').lsp_rename, bufopts)
    vim.keymap.set('n', '<leader>p', require('lspsaga.definition').preview_definition, bufopts)

    --vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufferoptions)
    vim.keymap.set('n', '<leader>ca', require('lspsaga.codeaction').code_action, bufopts)

    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>gr', require('lspsaga.finder').lsp_finder, bufopts)

    vim.keymap.set('n', '<leader>F', vim.lsp.buf.formatting, bufopts)
end

local lsp_flags = {
    debounce_text_changes = 150,
}

local lspconfig = require('lspconfig')


-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)


local servers = { 'pyright', 'clangd', 'volar', 'sumneko_lua', 'rust_analyzer', 'jdtls', 'tsserver', 'tailwindcss', 'svelte',
    'eslint', 'cssmodules_ls' }

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        flags = lsp_flags,
    })
end

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


-- luasnip setup
local luasnip = require 'luasnip'

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


-- Debugger {{{

local dap = require("dap")
local dapui = require("dapui")
local daptext = require("nvim-dap-virtual-text")

daptext.setup()

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js'},
}

dap.configurations.javascript = {
  {
    name = 'Node',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = require'dap.utils'.pick_process,
  },
}

dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = os.getenv('HOME') .. '/dev/microsoft/cpptools-linux/extension/debugAdapters/bin/OpenDebugAD7',
    options = {
        detached = false
    }
}

dap.configurations.c = {
    {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = true,
    },
    {
        name = 'Attach to gdbserver :1234',
        type = 'cppdbg',
        request = 'launch',
        MIMode = 'gdb',
        miDebuggerServerAddress = 'localhost:1234',
        miDebuggerPath = '/usr/bin/gdb',
        cwd = '${workspaceFolder}',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
    },
}

vim.keymap.set('n', '<F5>', ':lua require"dap".continue()<CR>')
vim.keymap.set('n', '<F6>', ':lua require"dap".step_over()<CR>')
vim.keymap.set('n', '<F7>', ':lua require"dap".step_into()<CR>')
vim.keymap.set('n', '<F8>', ':lua require"dap".step_out()<CR>')
vim.keymap.set('n', '<leader>b', ':lua require"dap".toggle_breakpoint()<CR>')

-- }}}


-- Keymaps {{{

local opts = { noremap = true }
local keymap = vim.api.nvim_set_keymap
local keymapno = function(keybind, action)
    keymap('n', keybind, action, opts)
end

keymap('i', 'jk', '<Esc>', opts)

keymapno('<leader>w', '<cmd>write<CR>')
keymapno('<leader>W', '<cmd>wq<CR>')
keymapno('<leader>q', '<cmd>quit<CR>')
keymapno('<leader>Q', '<cmd>q!<CR>')


-- editing and realoading configs
keymapno('<leader>ev', '<cmd>e $MYVIMRC<CR>')
keymapno('<leader>ez', '<cmd>e $HOME/.zshrc<CR>')
keymapno('<leader>et', '<cmd>e $HOME/.tmux.conf<CR>')
keymapno('<leader>rv', '<cmd>source $MYVIMRC<CR>')
keymapno('<leader>rp', '<cmd>PackerSync<CR>')

keymapno('<leader>ce', '<cmd>Copilot enable<CR>')
keymapno('<leader>cd', '<cmd>Copilot disable<CR>')
keymapno('<leader>cp', '<cmd>Copilot panel<CR>')
keymapno('<leader>cr', '<cmd>Copilot restart<CR>')

-- Telescope
keymapno('<leader>ff', '<cmd> Telescope find_files<CR>')
keymapno('<C-p>', '<cmd> Telescope git_files<CR>')
keymapno('<leader>fg', '<cmd> Telescope live_grep<CR>')
keymapno('<leader>fb', '<cmd> Telescope buffers<CR>')
keymapno('<leader>fh', '<cmd> Telescope help_tags<CR>')
keymapno('<leader>fm', '<cmd> Telescope man_pages<CR>')

-- }}}

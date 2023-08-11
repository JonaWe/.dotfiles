local Remap = require('jona.keymap')
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap
local vnoremap = Remap.vnoremap

local wk = require('which-key')

wk.register({
    f = {
        name = "Files/Find",
        f = { function() require("telescope.builtin").find_files({ hidden = true, prompt_title = "Find Files"}) end, "Find Files"},
        v = { require("jona.telescope").find_nvim_config, "Find Neovim Config"},
        p = { require('jona.telescope').find_project, "Find Project Files"},
        g = { "<cmd>Telescope live_grep<CR>", "Live Grep"},
        b = { "<cmd>Telescope buffers<CR>", "Buffers"},
    },
    c = {
        name = "Copilot",
        e = { "<cmd>Copilot enable", "Enable Copilot" },
        d = { "<cmd>Copilot disable", "Disable Copilot" },
        p = { "<cmd>Copilot panel", "Open Copilot Panel" },
        r = { "<cmd>Copilot restart", "Restart Copilot" },
    },
    p = {
        name = "Plugins",
        m = { "<cmd>Mason<CR>", "Mason" },
        l = { "<cmd>Lazy<CR>", "Lazy" },
    }
}, {
    prefix = "<leader>"
})

nnoremap('<leader>-', '<cmd>Ex<CR>')
inoremap('jk', '<Esc>')

nnoremap('<leader>w', '<cmd>write<CR>')
nnoremap('<leader>W', '<cmd>wq<CR>')
nnoremap('<leader>q', '<cmd>quit<CR>')
nnoremap('<leader>Q', '<cmd>q!<CR>')

nnoremap('<C-d>', '<C-d>zz')
nnoremap('<C-u>', '<C-u>zz')
nnoremap('n', 'nzzzv')
nnoremap('N', 'Nzzzv')

nnoremap('<leader>ez', '<cmd>e $HOME/.zshrc<CR>')
nnoremap('<leader>et', '<cmd>e $HOME/.tmux.conf<CR>')
nnoremap('<leader>rv', '<cmd>source $MYVIMRC<CR>')

nnoremap("<leader>xx", "<cmd>TroubleToggle<cr>")
nnoremap("<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
nnoremap("<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>")
nnoremap("<leader>xl", "<cmd>TroubleToggle loclist<cr>")
nnoremap("<leader>xq", "<cmd>TroubleToggle quickfix<cr>")
nnoremap("gR", "<cmd>TroubleToggle lsp_references<cr>")

nnoremap('<Leader>l', '<cmd>noh<CR>')

nnoremap('<C-_>', 'gcc')
inoremap('<C-_>', '<esc>gcci')
vnoremap('<C-_>', 'gb')

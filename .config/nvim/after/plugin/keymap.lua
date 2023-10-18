local Remap = require('jona.keymap')
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap
local vnoremap = Remap.vnoremap

local wk = require('which-key')

wk.register({
    c = {
        name = "Copilot",
        e = { "<cmd>Copilot enable<CR>", "Enable Copilot" },
        d = { "<cmd>Copilot disable<CR>", "Disable Copilot" },
        p = { "<cmd>Copilot panel<CR>", "Open Copilot Panel" },
        r = { "<cmd>Copilot restart<CR>", "Restart Copilot" },
    },
    e = {
        name = "Edit config files",
        c = { "<cmd>e $HOME/.steam/steam/steamapps/common/Counter-Strike\\ Global\\ Offensive/csgo/cfg/autoexec.cfg<CR>", "Load csgo config" },
        k = { "<cmd>e $HOME/.config/kitty/kitty.conf<CR>", "Load kitty config" },
        p = { "<cmd>e $HOME/.config/polybar/config.ini<CR>", "Load polybar config" },
        t = { "<cmd>e $HOME/.tmux.conf<CR>", "Load tmux config" },
        z = { "<cmd>e $HOME/.zshrc<CR>", "Load zsh config" },
    },
    f = {
        name = "Files/Find",
        b = { require("telescope.builtin").buffers, "Buffers" },
        f = { function() require("telescope.builtin").find_files({ hidden = false, prompt_title = "Find Files"}) end, "Find Files"},
        g = { require("telescope.builtin").live_grep, "Live Grep" },
        h = { function() require("telescope.builtin").find_files({ hidden = true, prompt_title = "Find Hidden Files"}) end, "Find Hidden Files"},
        p = { require('jona.telescope').find_project, "Find Project Files"},
        r = { require("telescope.builtin").oldfiles, "Recent Files" },
        v = { require("jona.telescope").find_nvim_config, "Find Neovim Config" },
    },
    h = { require("telescope.builtin").help_tags, "Neovim Docs"},
    p = {
        name = "Plugins",
        m = { "<cmd>Mason<CR>", "Mason" },
        l = { "<cmd>Lazy<CR>", "Lazy" },
    },
    ["q"] = { "<cmd>quit<CR>", "Quit" },
    ["Q"] = { "<cmd>quit!<CR>", "Quit (Ignore unsaved files)" },
    ["rv"] = { "<cmd>source $MYVIMRC<CR>", "Source neovim config" },
    ["sc"] = { "<cmd>noh<CR>", "Search clear" },
    t = {
        name = "Trouble",
        t = { "<cmd>TroubleToggle<CR>", "Opens Trubble" },
        w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Trouble Workspace Diagnostics" },
        d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Trouble Buffer Diagnostics" },
        l = { "<cmd>TroubleToggle loclist<cr>", "Trouble Loclist" },
        q = { "<cmd>TroubleToggle quickfix<cr>", "Trouble Quickfix List" },
    },
    u = {"<cmd>UndotreeToggle<CR><cmd>UndotreeFocus<CR>", "Toggle File Undotree" },
    ["w"] = { "<cmd>write<CR>", "Write Buffer" },
    ["W"] = { "<cmd>wq<CR>", "Write Buffer & Quit" },
    ["-"] = { "<cmd>Ex<CR>", "Opens Explorer" },
}, {
    prefix = "<leader>"
})

inoremap('jk', '<Esc>')

nnoremap('<C-d>', '<C-d>zz')
nnoremap('<C-u>', '<C-u>zz')
nnoremap('n', 'nzzzv')
nnoremap('N', 'Nzzzv')


nnoremap("gR", "<cmd>TroubleToggle lsp_references<cr>")


nnoremap('<C-_>', 'gcc')
inoremap('<C-_>', '<esc>gcci')
vnoremap('<C-_>', 'gb')

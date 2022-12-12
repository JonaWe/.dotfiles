local Remap = require('jona.keymap')
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap

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

nnoremap('<leader>ev', '<cmd>e $MYVIMRC<CR>')
nnoremap('<leader>ez', '<cmd>e $HOME/.zshrc<CR>')
nnoremap('<leader>et', '<cmd>e $HOME/.tmux.conf<CR>')
nnoremap('<leader>rv', '<cmd>source $MYVIMRC<CR>')
nnoremap('<leader>rp', '<cmd>PackerSync<CR>')

nnoremap('<leader>ce', '<cmd>Copilot enable<CR>')
nnoremap('<leader>cd', '<cmd>Copilot disable<CR>')
nnoremap('<leader>cp', '<cmd>Copilot panel<CR>')
nnoremap('<leader>cr', '<cmd>Copilot restart<CR>')

nnoremap('<C-p>', require('jona.telescope').find_project)
nnoremap('<leader>fv', require('jona.telescope').find_nvim_config)
nnoremap('<leader>ff', function()
	require('telescope.builtin').find_files({
		hidden = true,
        prompt_title = 'Find Files (hidden)'
	})
end)
nnoremap('<leader>fg', '<cmd> Telescope live_grep<CR>')
nnoremap('<leader>fb', '<cmd> Telescope buffers<CR>')

nnoremap("<leader>xx", "<cmd>TroubleToggle<cr>")
nnoremap("<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
nnoremap("<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>")
nnoremap("<leader>xl", "<cmd>TroubleToggle loclist<cr>")
nnoremap("<leader>xq", "<cmd>TroubleToggle quickfix<cr>")
nnoremap("gR", "<cmd>TroubleToggle lsp_references<cr>")

nnoremap('<Leader>l', ':noh<CR>')

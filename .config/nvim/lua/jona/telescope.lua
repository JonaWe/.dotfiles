local actions = require("telescope.actions")

require('telescope').setup({
    defaults = {
        files_sorter = require('telescope.sorters').get_fzy_sorter,
        mappings = {
            i = {
                ["<esc>"] = actions.close,
            },
        },
        file_ignore_patterns = {
            'node_modules',
        },

    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
    },
})
require('telescope').load_extension('fzy_native')

local M = {}

local function is_git_repo()
    vim.fn.system("git rev-parse --is-inside-work-tree")
    return vim.v.shell_error == 0
end

M.find_project = function()
    if is_git_repo() then
        require("telescope.builtin").git_files()
    else
        require("telescope.builtin").find_files()
    end
end

M.find_nvim_config = function()
	require("telescope.builtin").find_files({
		prompt_title = "Neovim Config",
		cwd = vim.env.HOME .. '/.config/nvim',
		hidden = true,
	})
end

return M

require('lualine').setup({
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { '%f' },
        lualine_x = { 'encoding', 'fileformat' },
        lualine_y = { 'filetype' },
        lualine_z = { '%l/%L:%c' }
    },
    winbar = {
        lualine_c = { 'filename' }
    },
    inactive_winbar = {
        lualine_c = { 'filename' }
    }
})

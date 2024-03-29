-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd("FocusGained", { command = "checktime" })

-- Go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPre", {
    pattern = "*",
    callback = function()
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "<buffer>",
            once = true,
            callback = function()
                vim.cmd(
                    [[if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif]]
                )
            end,
        })
    end,
})

-- windows to close
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "OverseerForm",
        "OverseerList",
        "floggraph",
        "fugitive",
        "git",
        "help",
        "lspinfo",
        "man",
        "neotest-output",
        "neotest-summary",
        "qf",
        "query",
        "spectre_panel",
        "startuptime",
        "toggleterm",
        "tsplayground",
        "vim",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

-- show cursor line only in active window
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
    callback = function()
        local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
        if ok and cl then
            vim.wo.cursorline = true
            vim.api.nvim_win_del_var(0, "auto-cursorline")
        end
    end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
    callback = function()
        local cl = vim.wo.cursorline
        if cl then
            vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
            vim.wo.cursorline = false
        end
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        local function map(mode, key, cmd, desc)
            vim.keymap.set(mode, key, cmd, { buffer = ev.buf, desc = desc })
        end

        map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
        map("n", "gd", vim.lsp.buf.definition, "Goto Defenition")
        map("n", "K", vim.lsp.buf.hover, "Hover")
        map("n", "gi", "<cmd>Telescope lsp_implementations<cr>", "Goto Implementation")
        map("n", "<leader>cr", vim.lsp.buf.rename, "Rename")
        map({ "n", "v" }, "<space>ca", require("actions-preview").code_actions,"Code Actions")
        map("n", "gr", "<cmd>Telescope lsp_references<cr>", "References")
        map({ "n", "v" }, "<leader>cf", function()
            require("conform").format({
                bufnr = ev.buf,
                timeout_ms = 500,
                lsp_fallback = true,
            })
        end, "Format")
    end,
})

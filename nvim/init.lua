-- Leader key (must be set before plugins)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- close quickfix on enter --
vim.api.nvim_create_autocmd(
  "FileType", {
  pattern={"qf"},
  command=[[nnoremap <buffer> <CR> <CR>:cclose<CR>]]})

-- Basic options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.updatetime = 250
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.autoread = true

-- Auto-reload files when changed externally
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
    pattern = '*',
    command = 'if mode() != "c" | checktime | endif',
})
vim.api.nvim_create_autocmd('FileChangedShellPost', {
    pattern = '*',
    callback = function()
        vim.notify('File changed on disk. Buffer reloaded.', vim.log.levels.WARN)
    end,
})

-- Load plugins
require('plugins')

-- Protected requires (only load if plugins are installed)
local function safe_require(module)
    local ok, result = pcall(require, module)
    if not ok then
        vim.notify('Module ' .. module .. ' not found. Run :Lazy sync', vim.log.levels.WARN)
        return nil
    end
    return result
end

-- Colorscheme
local tokyonight = safe_require('tokyonight')
if tokyonight then
    tokyonight.setup({
        style = 'night',
        transparent = false,
        terminal_colors = true,
    })
    vim.cmd([[colorscheme tokyonight]])
end

-- Load configs (after plugins)
if pcall(require, 'mason') then
    require('lsp')
end

if pcall(require, 'telescope') then
    require('telescope-config')
end

if pcall(require, 'cmp') then
    require('cmp-config')
end

-- Treesitter
local ts = safe_require('nvim-treesitter.configs')
if ts then
    ts.setup({
        ensure_installed = { 'lua', 'vim', 'vimdoc', 'javascript', 'typescript', 'python' },
        sync_install = false,
        auto_install = true,
        highlight = {
            enable = true,
        },
    })
end

-- Useful keymaps
vim.keymap.set('n', '<Esc>', ':nohlsearch<CR>', { silent = true })
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Save file' })
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Quit' })

-- NERDTree keymaps
vim.keymap.set('n', '<leader>nf', ':NERDTreeFind<CR>', { desc = 'NERDTree find file' })
vim.keymap.set('n', '<leader>nt', ':NERDTreeToggle<CR>', { desc = 'NERDTree toggle' })

-- Move selected lines up/down in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Diagnostics
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic float' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })

-- LSP keymaps
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Go to references' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover docs' })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })
vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, { desc = 'Format buffer' })

-- Venv selector
if pcall(require, 'venv-selector') then
    require('venv-selector').setup({
        name = { 'venv', '.venv', 'env', '.env' },
        auto_refresh = false,
    })
    vim.keymap.set('n', '<leader>vs', ':VenvSelect<CR>', { desc = 'Select Python venv' })
end

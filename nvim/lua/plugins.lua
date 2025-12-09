-- Bootstrap packer if not installed
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({
            'git', 'clone', '--depth', '1',
            'https://github.com/wbthomason/packer.nvim',
            install_path
        })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- Auto-reload neovim when plugins.lua is saved
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]])

return require('packer').startup(function(use)
    -- Packer manages itself
    use 'wbthomason/packer.nvim'

    -- Colorscheme
    use 'folke/tokyonight.nvim'

    -- Telescope (fuzzy finder)
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        requires = { 'nvim-lua/plenary.nvim' }
    }

    -- Mason (LSP installer)
    use {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
    }

    -- Treesitter (better syntax highlighting)
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    -- NERDTree (file explorer)
    use 'preservim/nerdtree'

    -- Autocompletion
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'rafamadriz/friendly-snippets',
        }
    }

    -- Python venv selector
    use {
        'linux-cultist/venv-selector.nvim',
        requires = {
            'neovim/nvim-lspconfig',
            'nvim-telescope/telescope.nvim',
            'mfussenegger/nvim-dap-python',
        }
    }

    -- Automatically sync after bootstrap
    if packer_bootstrap then
        require('packer').sync()
    end
end)

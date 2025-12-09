local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.setup({
    defaults = {
        file_ignore_patterns = { 'node_modules', '.git/' },
        mappings = {
            i = {
                ['<C-j>'] = 'move_selection_next',
                ['<C-k>'] = 'move_selection_previous',
            }
        }
    },
    pickers = {
        find_files = {
            hidden = true
        },
        live_grep = {
            additional_args = { "--hidden" }
        }
    }
})

-- Keymaps
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Find files' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Help tags' })
vim.keymap.set('n', '<leader>sr', builtin.oldfiles, { desc = 'Recent files' })
vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = 'Commands' })

-- List of patterns/files to ignore
local ignore_filetypes_list = {
  "venv",
  "target",
  "__pycache__",
  "%.xlsx",
  "%.pdf",
  "%.odt",
}

-- Require telescope safely
local telescope = require('telescope')
local builtin = require('telescope.builtin')

-- Telescope setup
telescope.setup({
  defaults = {
    file_ignore_patterns = ignore_filetypes_list,
  },
})



vim.keymap.set('n', '<leader>pf', builtin.find_files, {desc = "Find files"})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

--require('telescope').setup({
--  defaults = {
--    path_display = {
--      shorten = {
--        len = 3, exclude = {1, -1}
--      },
--      truncate = true
--    },
--    dynamic_preview_title = true,
--    mappings = {
--      n = {
--    	  ['<c-d>'] = require('telescope.actions').delete_buffer
--      },
--      i = {
--        ['<c-d>'] = require('telescope.actions').delete_buffer
--      },
--    },
--  },
--  extensions = {
--    fzf = {
--      fuzzy = true,                    -- false will only do exact matching
--      override_generic_sorter = true,  -- override the generic sorter
--      override_file_sorter = true,     -- override the file sorter
--      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
--                                       -- the default case_mode is "smart_case"
--    },
--  }
--})

-- require('telescope').load_extension('fzf')
-- require('telescope').load_extension('ui-select')
require('telescope').load_extension('dap')

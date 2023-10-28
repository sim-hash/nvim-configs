--- This file can be loaded by calling `lua require('plugins')` from your init.vim

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.0',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {'nvim-telescope/telescope-ui-select.nvim' }
  use {'nvim-telescope/telescope-dap.nvim' }

  use({
	  'gruvbox-community/gruvbox',
	  config = function()
		  vim.cmd('let g:nvcode_termcolors=256')
		  vim.cmd('let g:gruvbox_contrast_dark="soft"')
		  vim.cmd('colorscheme gruvbox')
	  end

  })

  use({
	  "folke/trouble.nvim",
	  config = function()
		  require("trouble").setup {
			  icons = false,
			  -- your configuration comes here
			  -- or leave it empty to use the default settings
			  -- refer to the configuration section below
		  }
	  end
  })

  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate'})
  use('nvim-treesitter/playground')
  use('theprimeagen/harpoon')
  use('mbbill/undotree')
  use('tpope/vim-fugitive')
  use("nvim-treesitter/nvim-treesitter-context")

  use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v1.x',
      requires = {
          -- LSP Support
          {'neovim/nvim-lspconfig'},             -- Required
          {                                      -- Optional
          'williamboman/mason.nvim',
          run = function()
              pcall(vim.cmd, 'MasonUpdate')
          end,
      },
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},         -- Required
      {'hrsh7th/cmp-nvim-lsp'},     -- Required
      {'hrsh7th/cmp-buffer'},       -- Optional
      {'hrsh7th/cmp-path'},         -- Optional
      {'saadparwaiz1/cmp_luasnip'}, -- Optional
      {'hrsh7th/cmp-nvim-lua'},     -- Optional

      -- Snippets
      {'L3MON4D3/LuaSnip'},             -- Required
      {'rafamadriz/friendly-snippets'}, -- Optional
  }
}


-- Lua
use {
    "folke/which-key.nvim",
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        require("which-key").setup {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    end
}
use("folke/zen-mode.nvim")
use("github/copilot.vim") 
use("eandrju/cellular-automaton.nvim")
use("laytan/cloak.nvim")
use("mfussenegger/nvim-dap")
use("mfussenegger/nvim-jdtls")
use("folke/neodev.nvim")
use{"rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
require("neodev").setup({
  library = { plugins = { "nvim-dap-ui" }, types = true }
})
end)

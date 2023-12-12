--- This file can be loaded by calling `lua require('plugins')` from your init.vim
return require('packer').startup(function(use)

    print("Inside packer")
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.4',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }
--  use {'nvim-telescope/telescope-ui-select.nvim' }
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
      branch = 'v3.x',
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
        require("marius.whichkey").setup {
            print("yolo marius is here")
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

-- Debugging
use {
    "mfussenegger/nvim-dap",
    opt = true,
    module = { "dap" },
    requires = {
    --    { "theHamsta/nvim-dap-virtual-text", module = { "nvim-dap-virtual-text" } },
    { "rcarriga/nvim-dap-ui", module = { "dapui" } },
    --    { "mfussenegger/nvim-dap-python", module = { "dap-python" } },
        "nvim-telescope/telescope-dap.nvim",
    --   { "leoluz/nvim-dap-go", module = "dap-go" },
    --  { "jbyuki/one-small-step-for-vimkind", module = "osv" },
    --  { "mxsdev/nvim-dap-vscode-js", module = { "dap-vscode-js" } },
    },
    config = function()
        require("marius.dap").setup()
    end,
    disable = false,
}

--use {
--    "rcarriga/nvim-dap-ui", requires = {
--        "mfussenegger/nvim-dap"
--    } 
--}
use("mfussenegger/nvim-jdtls")
use("folke/neodev.nvim")
require("neodev").setup({
    library = { plugins = { "nvim-dap-ui" }, types = true }
})
end)

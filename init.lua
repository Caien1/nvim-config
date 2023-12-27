vim.wo.relativenumber=true
vim.wo.number=true
vim.g.mapleader = " "
--lazy vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins= {
	{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
	{'neovim/nvim-lspconfig'},
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/nvim-cmp'},
	{'L3MON4D3/LuaSnip'},
	{"catppuccin/nvim", name = "catppuccin", priority = 1000},
	{'nvim-telescope/telescope.nvim', tag = '0.1.5', dependencies = { "nvim-lua/plenary.nvim"}},
	{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
	{"williamboman/mason.nvim"},
	{"ThePrimeagen/vim-be-good"}
}
local opts = {}

require("lazy").setup(plugins, opts)
require("mason").setup()





-----------------------------------------------------------

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = {  "javascript" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
 -- ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    --disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
------------------------------------------------------------






local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.setup()
 local builtin = require("telescope.builtin")
 require('telescope').setup{ 
  defaults = { 
    file_ignore_patterns = { 
      "node_modules",".git",".vscode" 
    }
  }
}
 vim.keymap.set('n','<leader>ff',builtin.find_files,{})
 vim.keymap.set('n','<leader>fg',builtin.live_grep,{})
 require("catppuccin").setup()
 vim.cmd.colorscheme "catppuccin"

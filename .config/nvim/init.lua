--                        _           
--  _ __   ___  _____   _(_)_ __ ___  
-- | '_ \ / _ \/ _ \ \ / / | '_ ` _ \ 
-- | | | |  __/ (_) \ V /| | | | | | |
-- |_| |_|\___|\___/ \_/ |_|_| |_| |_|
--                                    

----- L A Z Y -----

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

----- P L U G I N S -----

local plugins = {
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.3',
		dependencies = { 'nvim-lua/plenary.nvim' },
	},
	{
		'nvim-treesitter/nvim-treesitter', build = ':TSUpdate',
		dependencies = {'nvim-treesitter/nvim-treesitter-textobjects'},
	},
	{
		'lukas-reineke/indent-blankline.nvim',
		main = "ibl",
		opts = {
			char = '┊',
			show_trailing_blankline_indent = false,
		}
	},
	{
		'VonHeikemen/lsp-zero.nvim', branch = 'v3.x',
		dependencies = {
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			'hrsh7th/nvim-cmp',
			'hrsh7th/cmp-nvim-lsp',
			'L3MON4D3/LuaSnip',
			'nvim-lualine/lualine.nvim',
		},
	},
	{
		'sainnhe/everforest',
		priority = 1000,
		config = function()
			vim.cmd.colorscheme 'everforest'
		end,
	},
	'nanozuki/tabby.nvim',
}

local opts = {}

require('lazy').setup(plugins)


----- T E L E S C O P E -----

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files,   { desc = '[S]earch Gi[T] Files'    })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files,  { desc = '[S]earch [F]iles'        })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags,   { desc = '[S]earch [H]elp'         })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep,   { desc = '[S]earch by [G]rep'      })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics'  })

----- T R E E S I T T E R -----

require('nvim-treesitter.configs').setup {
  ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query', 'javascript', 'typescript', 'python', 'markdown', 'bash', 'go', 'rust' },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

----- L U A L I N E -----

require('lualine').setup({
	opts = {
		options = {
			theme = 'evergreen',
			icons_enabled = true,
			component_separators = {left = '' , right = '' },
			section_separators   = {left = '|', right = '|'},
		}
	}
})

----- L S P -----

local lsp = require('lsp-zero')
lsp.preset("recommended")

local cmp = require('cmp')
local cmp_action = lsp.cmp_action()

cmp.setup({
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-n>'] = cmp_action.luasnip_jump_forward(),
    ['<C-p>'] = cmp_action.luasnip_jump_backward(),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  })
})

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }
	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
end)

lsp.setup()
-- require('lspconfig').setup()

----- M A S O N -----

require('mason').setup()

----- T A B B Y -----

require('tabby').setup()
require('ibl').setup()

-- require('neovim/nvim-lspconfig').setup()

-- THEMES
--
-- return {
-- 	'sainnhe/everforest',
-- 	priority = 1000,
-- 	config = function()
-- 		vim.cmd.colorscheme 'everforest'
-- 	end,
-- }

----- S O L A R I Z E D -----

-- return {
--   'tsuzat/neosolarized.nvim',
--   lazy = false,
--   priority = 1000,
--   config = function()
--     vim.cmd.colorscheme 'NeoSolarized'
--   end,
-- }


----- O N E D A R K -----

-- return {
--   'navarasu/onedark.nvim',
--   priority = 1000,
--   config = function()
--     vim.cmd.colorscheme 'onedark'
--   end,
-- }


----- C A T P P U C C I N -----

-- return {
--   "catppuccin/nvim",
--   name = "catppuccin",
--   priority = 1000,
--   config = function()
--     vim.cmd.colorscheme 'catppuccin'
--   end,
-- }

----- D R A C U L A -----

-- return {
--   'Mofiqul/dracula.nvim',
--   priority = 1000,
--   config = function()
--     vim.cmd.colorscheme 'dracula'
--   end,
-- }

----- G R U V B O X -----

-- return {
--   'morhetz/gruvbox',
--   priority = 1000,
--   config = function()
--     vim.cmd.colorscheme 'gruvbox'
--   end,
-- }

--
-- 	lsp
--
-- 	branch = 'v3.x',
-- 	dependencies = {
-- 		'williamboman/mason.nvim',
-- 		'williamboman/mason-lspconfig.nvim',
-- 		'neovim/nvim-lspconfig',
-- 		'hrsh7th/cmp-nvim-lsp',
-- 		'hrsh7th/nvim-cmp',
-- 		'L3MON4D3/LuaSnip',
-- 	}

-- 
-- require('lazy').setup({
--   'tpope/vim-sleuth',
--   { -- LSP Configuration & Plugins
--     'neovim/nvim-lspconfig',
--     dependencies = {
--       -- Automatically install LSPs to stdpath for neovim
--       'williamboman/mason.nvim',
--       'williamboman/mason-lspconfig.nvim',
-- 
--       -- Useful status updates for LSP
--       -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
--       { 'j-hui/fidget.nvim', tag = 'legacy' },
-- 
--       -- Additional lua configuration, makes nvim stuff amazing!
--       'folke/neodev.nvim',
--     },
--   },
-- 
--   {
--     'hrsh7th/nvim-cmp',
--     dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
--   },
--   -- {
--   --   'folke/which-key.nvim',
--   --   opts = {},
--   -- },

-- 
--   -- "gc" to comment visual regions/lines
--   { 'numToStr/Comment.nvim', opts = {} },
--   -- { 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },
-- 
--   -- Fuzzy Finder Algorithm which requires local dependencies to be built.
--   -- Only load if `make` is available. Make sure you have the system
--   -- requirements installed.
--   -- {
--   --   'nvim-telescope/telescope-fzf-native.nvim',
--   --   -- NOTE: If you are having trouble with this installation,
--   --   --       refer to the README for telescope-fzf-native for more instructions.
--   --   build = 'make',
--   --   cond = function()
--   --     return vim.fn.executable 'make' == 1
--   --   end,
--   -- },
--   { -- Highlight, edit, and navigate code
--     'nvim-treesitter/nvim-treesitter',
--     dependencies = {
--       'nvim-treesitter/nvim-treesitter-textobjects',
--     },
--     config = function()
--       pcall(require('nvim-treesitter.install').update { with_sync = true })
--     end,
--   },
-- 
--   -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
--   --       These are some example plugins that I've included in the kickstart repository.
--   --       Uncomment any of the lines below to enable them.
--   -- require 'kickstart.plugins.autoformat',
--   -- require 'kickstart.plugins.debug',
-- 
--   -- NOTE: The import below automatically adds your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
--   --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
--   --    up-to-date with whatever is in the kickstart repo.
--   --
--   --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
--   --
--   --    An additional note is that if you only copied in the `init.lua`, you can just comment this line
--   --    to get rid of the warning telling you that there are not plugins in `lua/custom/plugins/`.
--   -- { import = 'custom.plugins' },
-- }, {})
-- 
-- -- [[ Basic Keymaps ]]
-- 
-- -- Keymaps for better default experience
-- -- See `:help vim.keymap.set()`
-- vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
-- 
-- -- Remap for dealing with word wrap
-- vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- 
-- 
-- -- [[ Highlight on yank ]]
-- -- See `:help vim.highlight.on_yank()`
-- -- local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
-- -- vim.api.nvim_create_autocmd('TextYankPost', {
-- --   callback = function()
-- --     vim.highlight.on_yank()
-- --   end,
-- --   group = highlight_group,
-- --   pattern = '*',
-- -- })
-- 
-- -- [[ Configure Telescope ]]
-- -- See `:help telescope` and `:help telescope.setup()`
-- -- require('telescope').setup {
-- --   defaults = {
-- --     mappings = {
-- --       i = {
-- --         ['<C-u>'] = false,
-- --         ['<C-d>'] = false,
-- --       },
-- --     },
-- --   },
-- -- }
-- 
-- -- Enable telescope fzf native, if installed
-- -- pcall(require('telescope').load_extension, 'fzf')
-- 
-- -- See `:help telescope.builtin`
-- -- vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
-- -- vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
-- -- vim.keymap.set('n', '<leader>/', function()
-- --   -- You can pass additional configuration to telescope to change theme, layout, etc.
-- --   require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
-- --     winblend = 10,
-- --     previewer = false,
-- --   })
-- -- end, { desc = '[/] Fuzzily search in current buffer' })
-- 
-- require('nvim-treesitter.configs').setup {
--   -- Add languages to be installed here that you want installed for treesitter
--   ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim' },
--   -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
--   auto_install = false,
--   highlight = { enable = true },
--   indent = { enable = true, disable = { 'python' } },
--   incremental_selection = {
--     enable = true,
--     keymaps = {
--       init_selection = '<c-space>',
--       node_incremental = '<c-space>',
--       scope_incremental = '<c-s>',
--       node_decremental = '<M-space>',
--     },
--   },
--   textobjects = {
--     select = {
--       enable = true,
--       lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
--       keymaps = {
--         -- You can use the capture groups defined in textobjects.scm
--         ['aa'] = '@parameter.outer',
--         ['ia'] = '@parameter.inner',
--         ['af'] = '@function.outer',
--         ['if'] = '@function.inner',
--         ['ac'] = '@class.outer',
--         ['ic'] = '@class.inner',
--       },
--     },
--     move = {
--       enable = true,
--       set_jumps = true, -- whether to set jumps in the jumplist
--       goto_next_start = {
--         [']m'] = '@function.outer',
--         [']]'] = '@class.outer',
--       },
--       goto_next_end = {
--         [']M'] = '@function.outer',
--         [']['] = '@class.outer',
--       },
--       goto_previous_start = {
--         ['[m'] = '@function.outer',
--         ['[['] = '@class.outer',
--       },
--       goto_previous_end = {
--         ['[M'] = '@function.outer',
--         ['[]'] = '@class.outer',
--       },
--     },
--     swap = {
--       enable = true,
--       swap_next = {
--         ['<leader>a'] = '@parameter.inner',
--       },
--       swap_previous = {
--         ['<leader>A'] = '@parameter.inner',
--       },
--     },
--   },
-- }
-- 
-- -- Diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
-- 
-- -- LSP settings.
-- --  This function gets run when an LSP connects to a particular buffer.
-- local on_attach = function(_, bufnr)
--   -- NOTE: Remember that lua is a real programming language, and as such it is possible
--   -- to define small helper and utility functions so you don't have to repeat yourself
--   -- many times.
--   --
--   -- In this case, we create a function that lets us more easily define mappings specific
--   -- for LSP related items. It sets the mode, buffer and description for us each time.
--   local nmap = function(keys, func, desc)
--     if desc then
--       desc = 'LSP: ' .. desc
--     end
-- 
--     vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
--   end
-- 
--   nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
--   nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
-- 
--   nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
--   -- nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
--   -- nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
--   -- nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
--   -- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
--   -- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
-- 
--   -- See `:help K` for why this keymap
--   nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
--   nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
-- 
--   -- Lesser used LSP functionality
--   nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
--   nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
--   nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
--   nmap('<leader>wl', function()
--     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--   end, '[W]orkspace [L]ist Folders')
-- 
--   -- Create a command `:Format` local to the LSP buffer
--   vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
--     vim.lsp.buf.format()
--   end, { desc = 'Format current buffer with LSP' })
-- end
-- 
-- --  Add any additional override configuration in the following tables. They will be passed to
-- --  the `settings` field of the server config. You must look up that documentation yourself.
-- local servers = {
--   -- clangd = {},
--   -- gopls = {},
--   -- pyright = {},
--   -- rust_analyzer = {},
--   -- tsserver = {},
-- 
--   lua_ls = {
--     Lua = {
--       workspace = { checkThirdParty = false },
--       telemetry = { enable = false },
--     },
--   },
-- }
-- 
-- -- Setup neovim lua configuration
-- require('neodev').setup()
-- 
-- -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
-- 
-- -- Setup mason so it can manage external tooling
-- require('mason').setup()
-- 
-- -- Ensure the servers above are installed
-- local mason_lspconfig = require 'mason-lspconfig'
-- 
-- mason_lspconfig.setup {
--   ensure_installed = vim.tbl_keys(servers),
-- }
-- 
-- mason_lspconfig.setup_handlers {
--   function(server_name)
--     require('lspconfig')[server_name].setup {
--       capabilities = capabilities,
--       on_attach = on_attach,
--       settings = servers[server_name],
--     }
--   end,
-- }
-- 
-- -- nvim-cmp setup
-- local cmp = require 'cmp'
-- local luasnip = require 'luasnip'
-- 
-- luasnip.config.setup {}
-- 
-- cmp.setup {
--   snippet = {
--     expand = function(args)
--       luasnip.lsp_expand(args.body)
--     end,
--   },
--   mapping = cmp.mapping.preset.insert {
--     ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-f>'] = cmp.mapping.scroll_docs(4),
--     ['<C-Space>'] = cmp.mapping.complete {},
--     ['<CR>'] = cmp.mapping.confirm {
--       behavior = cmp.ConfirmBehavior.Replace,
--       select = true,
--     },
--     -- ['<Tab>'] = cmp.mapping(function(fallback)
--     --   if cmp.visible() then
--     --     cmp.select_next_item()
--     --   elseif luasnip.expand_or_jumpable() then
--     --     luasnip.expand_or_jump()
--     --   else
--     --     fallback()
--     --   end
--     -- end, { 'i', 's' }),
--     ['<S-Tab>'] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_prev_item()
--       elseif luasnip.jumpable(-1) then
--         luasnip.jump(-1)
--       else
--         fallback()
--       end
--     end, { 'i', 's' }),
--   },
--   sources = {
--     { name = 'nvim_lsp' },
--     { name = 'luasnip' },
--   },
-- }


-- OLD VIM CONFIGURATION --


-- "        _                    
-- " __   _(_)_ __ ___  _ __ ___ 
-- " \ \ / / | '_ ` _ \| '__/ __|
-- "  \ V /| | | | | | | | | (__ 
-- "   \_/ |_|_| |_| |_|_|  \___|
-- "                             
-- 
-- syntax on
-- set autoindent
-- set nocompatible
-- filetype plugin on
-- set path+=**
-- set wildmenu
-- set number
-- set relativenumber
-- set ignorecase
-- set listchars=eol:¬,tab:▶-
-- set list
-- set tabstop=4
-- set shiftwidth=4
-- 
-- "--- PLUGINS ---"
-- "curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
-- 
-- call plug#begin()
-- Plug 'HerringtonDarkholme/yats.vim'
-- Plug 'preservim/nerdtree'
-- Plug 'rafi/awesome-vim-colorschemes'
-- Plug 'ryanoasis/vim-devicons'
-- Plug 'vim-airline/vim-airline'
-- Plug 'vim-airline/vim-airline-themes'
-- Plug 'vimwiki/vimwiki'
-- Plug 'junegunn/goyo.vim'
-- Plug 'junegunn/fzf'
-- Plug 'ap/vim-css-color'
-- Plug 'neoclide/coc.nvim', {'branch':'release'}
-- Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
-- Plug 'davidhalter/jedi-vim'
-- Plug 'altercation/vim-colors-solarized'
-- Plug 'dracula/vim', {'name':'dracula'}
-- call plug#end()
-- 
-- "--- THEMES ---"
-- colorscheme dracula
-- let g:airline_theme = 'dracula'
-- hi Normal ctermbg=None
-- "hi LineNr ctermbg=None
-- "hi NonText ctermbg=None
-- 
-- "--- SETTINGS ---"
-- let g:coc_disable_startup_warning = 1
-- let g:vimwiki_list=[{'path':'~/.local/vimwiki'}]
-- 
-- "--- MAPS ---"
-- nnoremap <C-e> :NERDTreeToggle<CR>:<Backspace><ESC>
-- inoremap <C-e> <ESC>:NERDTreeToggle<CR>:<Backspace><ESC>
-- 
-- " Reset colors for transparency after returning from Goyo
-- noremap <C-g> :Goyo<CR>:hi Normal ctermbg=None<CR>
-- 
-- "--- PRESENTATION ---"
-- autocmd VimEnter *.ppvt setl window=32
-- 
-- "--- SPECIAL CHARACTERS ---"
-- " <BS>           Backspace
-- " <Tab>          Tab
-- " <CR>           Enter
-- " <Enter>        Enter
-- " <Return>       Enter
-- " <Esc>          Escape
-- " <Space>        Space
-- " <Up>           Up arrow
-- " <Down>         Down arrow
-- " <Left>         Left arrow
-- " <Right>        Right arrow
-- " <F1> - <F12>   Function keys 1 to 12
-- " #1, #2..#9,#0  Function keys F1 to F9, F10
-- " <Insert>       Insert
-- " <Del>          Delete
-- " <Home>         Home
-- " <End>          End
-- " <PageUp>       Page-Up
-- " <PageDown>     Page-Down
-- " <bar>          the '|' character, which otherwise needs to be escaped '\|'
-- 
-- " command! <func name> <func body>
-- 
-- " JUMPER
-- "inoremap <Space><Space> <Esc>/<CR>4xs
-- 
-- 
-- " - - - N O O B - - - "
-- inoremap <Up>    NOOB
-- inoremap <Down>  STOP<Space>BEING<Space>STUPID
-- inoremap <Left>  NOOB
-- inoremap <Right> STOP<Space>BEING<Space>STUPID
-- 
-- 
-- "--- Set File Types ---"
-- autocmd BufNewFile,BufRead *.todo set filetype=todo
-- autocmd BufNewFile,BufRead *.tex  set filetype=latex
-- autocmd BufNewFile,BufRead *.py   set filetype=python
-- autocmd BufNewFile,BufRead *.h    set filetype=c
-- autocmd BufNewFile,BufRead *.c    set filetype=c
-- 
-- 
-- "--- Python ---"
-- autocmd FileType python noremap == <ESC>:w<CR>:!clear && python %<CR>
-- 
-- "--- C ---"
-- autocmd FileType c noremap == <ESC>:w<CR>:!clear && make<CR>
-- 
-- "--- HTML ---"
-- autocmd FileType html noremap == <ESC>:w<CR>:!clear && google-chrome %&<CR>
-- 
-- 
-- "--- FAVUNI ---"
-- inoremap =-=   ≡
-- inoremap ->>   →
-- inoremap tickk ✓
-- inoremap boxx  ☐
-- inoremap boxt  ☒
-- inoremap +-    ±
-- inoremap <--   ←
-- inoremap *(    ★
--

----- B A S E -----

vim.g.mapleader = '\\'
vim.g.maplocalleader = '\\'
vim.o.background = 'dark'
vim.o.breakindent = true
vim.o.clipboard = 'unnamedplus'
vim.o.completeopt = 'menuone,noselect'
vim.o.ignorecase = true
vim.o.shiftwidth = 4
vim.o.smartcase = true
vim.o.tabstop = 4
vim.o.termguicolors = true
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.undofile = true
vim.o.updatetime = 250
vim.opt.ai = true
vim.opt.autoindent = true
vim.opt.backspace = 'start,eol,indent'
vim.opt.breakindent = true
vim.opt.cmdheight = 1
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.guicursor = ""
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.laststatus = 2
vim.opt.list = true
vim.opt.listchars = { eol = '¬', tab = '▶-' }
vim.opt.path:append { '**' }
vim.opt.scrolloff = 2
vim.opt.shell = 'bash'
vim.opt.showcmd = true
vim.opt.si = true
vim.opt.smarttab = true
vim.opt.title = true
vim.opt.wildignore:append { '*/node_modules/*', '*/__pycache__/*' }
vim.scriptencoding = 'utf-8'
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = 'no'
vim.wo.wrap = true
vim.api.nvim_set_hl(0, 'Normal', { bg = None })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = None })

----- F A V U N I -----

vim.keymap.set('i', '=-=',  '≡')
vim.keymap.set('i', '->>',  '→')
vim.keymap.set('i', 'tickk','✓')
vim.keymap.set('i', 'boxx', '☐')
vim.keymap.set('i', 'boxt', '☒')
vim.keymap.set('i', '+-',   '±')
vim.keymap.set('i', '<--',  '←')
vim.keymap.set('i', '*(',   '★')

----- K E Y M A P -----

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

----- * * *  F I N  * * * -----

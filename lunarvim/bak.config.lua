--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "onedarker"
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
    --   -- for input mode
    i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
    },
    --   -- for normal mode
    n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
    },
}
-- Change theme settings
-- lvim.builtin.theme.options.dim_inactive = true
-- lvim.builtin.theme.options.style = "storm"

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
    name = "+Trouble",
    r = { "<cmd>Trouble lsp_references<cr>", "References" },
    f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
    d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
    q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
    l = { "<cmd>Trouble loclist<cr>", "LocationList" },
    w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
    "bash",
    "c",
    "javascript",
    "json",
    "lua",
    "python",
    "typescript",
    "tsx",
    "css",
    "rust",
    "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
-- lvim.lsp.installer.setup.ensure_installed = {
--     "sumeko_lua",
--     "jsonls",
-- }
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    --   { command = "black", filetypes = { "python" } },
    --   { command = "isort", filetypes = { "python" } },
    {
        command = "prettier",
        timeout = 1000,
        --     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
        --     ---@usage arguments to pass to the formatter
        --     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
        --     extra_args = { "--print-with", "100" },
        --     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
        filetypes = { "typescript", "typescriptreact" },
    },
}

-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   {
--     exe = "prettier",
--     filetypes = { "javascript", "typescript", "typescriptreact", "css", "markdown", "json", "html" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
    {
        exe = "eslint",
        filetypes = { "javascript", "typescript", "typescriptreact" },
    },
}

-- Additional Plugins
lvim.plugins = {
    --     {"folke/tokyonight.nvim"},
    --     {
    --       "folke/trouble.nvim",
    --       cmd = "TroubleToggle",
    --     },

    { "tomlion/vim-solidity" },
    -- {
    --  "tzachar/cmp-tabnine",
    --  config = function ()
    --  local tabnine = require('cmp_tabnine.config')
    --  tabnine:setup({
    --       max_lines = 1000;
    --       max_num_results = 20;
    --       sort = true;
    --   	  run_on_every_keystroke = true;
    --      snippet_placeholder = '..';
    --    })
    -- end,

    --  run = "./install.sh",
    --  requires = "hrsh7th/nvim-cmp",
    -- },
    { "sbdchd/neoformat" },
    { "tpope/vim-fugitive" },
    { "https://github.com/github/copilot.vim" },
    { "ThePrimeagen/refactoring.nvim" },
    { "c0r73x/vimdir.vim" },
    { "mg979/vim-visual-multi" },
    --     {"folke/tokyonight.nvim"}, {
    --         "ray-x/lsp_sign:hature.nvim",
    --         config = function() require"lsp_signature".on_attach() end,
    --         event = "InsertEnter"
    --     }

    -- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#solang
    -- For solidity
    require 'lspconfig'.solang.setup {
        cmd = { "solang", "--language-server" },
        filetypes = { "solidity" },
        root_dir = require("lspconfig").util.root_pattern(".git"),
    }
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }


local map = vim.api.nvim_set_keymap
-- toggle numbers on side. improving yanking while visual selection active in tmux without selecting numbbers
map('n', '<C-n>', ':set nu!<cr>:set rnu!<cr>', { noremap = true })
-- }

--  local set rnu
vim.api.nvim_command('set rnu')
-- https://www.reddit.com/r/neovim/comments/3v06lo/making_the_background_transparent/
vim.api.nvim_command('au ColorScheme * hi Normal ctermbg=none guibg=none')

-- Neoformat is part of prettier
-- https://prettier.io/docs/en/vim.html#neoformathttpsgithubcomsbdchdneoformat
vim.api.nvim_command('let g:neoformat_try_node_exe = 1')
vim.api.nvim_command('autocmd BufWritePre *.js* Neoformat')
-- vim.api.nvim_command('autocmd BufWritePre *.jsx Neoformat')
vim.api.nvim_command('autocmd BufWritePre *.ts* Neoformat')
-- vim.api.nvim_command('autocmd BufWritePre *.tsx Neoformat')
vim.api.nvim_command('autocmd BufWritePre *.md Neoformat')
vim.api.nvim_command('autocmd BufWritePre *.json Neoformat')
vim.api.nvim_command('autocmd BufWritePre *.css Neoformat')
vim.api.nvim_command('autocmd BufWritePre *.html Neoformat')
-- https://github.com/mhinz/vim-galore#clipboard-usage-windows-macos
-- If you don't even want to specify the * register all the time, put this in your vimrc:
-- Usually all yank/delete/put operations fill the " register, now the * register is used for the same operations, therefore simply y and p will be enough.
-- Let me repeat: Using the option above means that every yank/paste, even when only used in the same Vim window, will alter the clipboard. Decide for yourself if this is useful or not.
vim.api.nvim_command('set clipboard=unnamed')

-- refactor
require('refactoring').setup({})
-- load refactoring Telescope extension
require("telescope").load_extension("refactoring")
lvim.builtin.which_key.vmappings["r"] = { "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
    "Refactor" }
lvim.builtin.which_key.mappings["r"] = { "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
    "Refactor" }

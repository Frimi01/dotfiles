-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Local Variables
local opt = vim.opt
local g = vim.g
local api = vim.api
local cmd = vim.cmd
local keymap = vim.keymap.set

-- OPTIONS

opt.clipboard = "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
opt.cursorline = true -- Enable highlighting of the current line
opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}
opt.foldlevel = 99
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true
opt.inccommand = "nosplit" -- preview incremental substitute
opt.jumpoptions = "view"
opt.laststatus = 3 -- global statusline
opt.linebreak = true -- Wrap lines at convenient points
opt.list = true -- Show some invisible characters (tabs...
opt.pumblend = 10 -- Popup blend
opt.ruler = false -- Disable the default ruler
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true -- Round indent
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.spelllang = { "en" }
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.termguicolors = true -- True color support
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = true -- Disable line wrap

opt.tabstop = 4
opt.shiftwidth = 4
opt.number = true
opt.relativenumber = true
opt.textwidth = 80
opt.colorcolumn = "80"

opt.breakindent = true
opt.showbreak = "↳ "
-- Treesitter now does this: cmd("syntax on")

g.mapleader = " "
g.maplocalleader = "\\"

api.nvim_create_autocmd("VimEnter", {
	callback = function()
		api.nvim_set_hl(0, "LineNr0", { fg = "#dedede" })
		api.nvim_set_hl(0, "LineNr1", { fg = "#bdbdbd" })
		api.nvim_set_hl(0, "LineNr2", { fg = "#9c9c9c" })
		api.nvim_set_hl(0, "LineNr3", { fg = "#7b7b7b" })
		api.nvim_set_hl(0, "LineNr4", { fg = "#5a5a5a" })
	end,
})
local separator = " ▎ "
opt.statuscolumn = '%s%=%#LineNr4#%{(v:relnum >= 4)?v:relnum."'
	.. separator
	.. '":""}'
	.. '%#LineNr3#%{(v:relnum == 3)?v:relnum."'
	.. separator
	.. '":""}'
	.. '%#LineNr2#%{(v:relnum == 2)?v:relnum."'
	.. separator
	.. '":""}'
	.. '%#LineNr1#%{(v:relnum == 1)?v:relnum."'
	.. separator
	.. '":""}'
	.. '%#LineNr0#%{(v:relnum == 0)?v:lnum."'
	.. separator
	.. '":""}'

---- Language fix
--opt.langmenu = "en_US"
--cmd("language en_US")
--
---- terminal shell
--opt.shell = "pwsh"
--opt.shellcmdflag = "-NoLogo"

-- PLUGINS
require("lazy").setup({
	spec = { --ADD PLUGINS HERE
		{ "echasnovski/mini.nvim", version = false },
		{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			config = function()
				require("nvim-treesitter.configs").setup({
					ensure_installed = { "lua", "python", "rust", "javascript", "bash", "html", "css" }, -- add more as needed
					highlight = { enable = true },
					indent = { enable = true },
					auto_install = true,
				})
			end,
		},
		{
			"folke/flash.nvim",
			event = "VeryLazy",
			---@type Flash.Config
			opts = {},
                        -- stylua: ignore
                        keys = {
                                { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,   desc = "Flash" },
                                { "r",     mode = "o",               function() require("flash").remote() end, desc = "Remote Flash" },
                                { "<c-s>", mode = { "c" },           function() require("flash").toggle() end, desc = "Toggle Flash Search" },
                        },
		},
		{
			"nvim-telescope/telescope.nvim",
			tag = "0.1.8",
			dependencies = { "nvim-lua/plenary.nvim" },
		},
		{
			"neovim/nvim-lspconfig",
		},
		{
			"stevearc/conform.nvim",
			opts = {},
		},
		{
			"hrsh7th/nvim-cmp",
			dependencies = {
				"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
				"hrsh7th/cmp-buffer", -- buffer completions
				"hrsh7th/cmp-path", -- path completions
				"hrsh7th/cmp-cmdline", -- cmdline completions
			},
		},
		{
			"folke/which-key.nvim",
			event = "VeryLazy",
			opts = {
				preset = "helix",
				defaults = {},
				spec = {
					{
						mode = { "n", "v" },
						{ "<leader><tab>", group = "tabs" },
						{ "<leader>c", group = "code" },
						{ "<leader>d", group = "debug" },
						{ "<leader>dp", group = "profiler" },
						{ "<leader>f", group = "file/find" },
						{ "<leader>g", group = "git" },
						{ "<leader>gh", group = "hunks" },
						{ "<leader>q", group = "quit/session" },
						{ "<leader>s", group = "search" },
						{ "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
						{ "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
						{ "[", group = "prev" },
						{ "]", group = "next" },
						{ "g", group = "goto" },
						{ "gs", group = "surround" },
						{ "z", group = "fold" },
						{
							"<leader>b",
							group = "buffer",
							expand = function()
								return require("which-key.extras").expand.buf()
							end,
						},
						{
							"<leader>w",
							group = "windows",
							proxy = "<c-w>",
							expand = function()
								return require("which-key.extras").expand.win()
							end,
						},
						-- better descriptions
						{ "gx", desc = "Open with system app" },
					},
				},
			},
			keys = {
				{
					"<leader>?",
					function()
						require("which-key").show({ global = false })
					end,
					desc = "Buffer Local Keymaps (which-key)",
				},
			},
		},
		{
			"lewis6991/gitsigns.nvim",
			opts = {
				signs = {
					add = { text = "▎" },
					change = { text = "▎" },
					delete = { text = "" },
					topdelete = { text = "" },
					changedelete = { text = "▎" },
					untracked = { text = "▎" },
				},
				signs_staged = {
					add = { text = "▎" },
					change = { text = "▎" },
					delete = { text = "" },
					topdelete = { text = "" },
					changedelete = { text = "▎" },
				},
			},
		},
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})

require("mini.ai").setup()
require("mini.icons").setup()
require("mini.statusline").setup()
require("mini.pairs").setup()
require("mini.sessions").setup()
require("mini.indentscope").setup({
	draw = {
		delay = 0,
		animation = require("mini.indentscope").gen_animation.none(),
	},
})
require("catppuccin").setup({
	flavour = "mocha",
})

cmd.colorscheme("catppuccin")
api.nvim_exec_autocmds("FileType", {})

-- Formatter
local lspconfig = require("lspconfig")

-- Capabilities to support nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()
lspconfig.ts_ls.setup({
	capabilities = capabilities,
})
lspconfig.gopls.setup({
	capabilities = capabilities,
})
lspconfig.jdtls.setup({
	capabilities = capabilities,
})
-- cmp.lua
local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			-- You can use luasnip or other engines here
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "path" },
	}),
})

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    json = { "prettier" },
    html = { "prettier" },
    css = { "prettier" },
  },_on_save = {
		lsp_fallback = true,
		timeout_ms = 500,
	},
})

-- STARTER SCREEN
local starter = require("mini.starter")
starter.setup({
	-- evaluate_single = true,
	header = "███████╗██████╗ ██╗██╗   ██╗██╗███╗   ███╗\n"
		.. "██╔════╝██╔══██╗██║██║   ██║██║████╗ ████║\n"
		.. "█████╗  ██████╔╝██║██║   ██║██║██╔████╔██║\n"
		.. "██╔══╝  ██╔══██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║\n"
		.. "██║     ██║  ██║██║ ╚████╔╝ ██║██║ ╚═╝ ██║\n"
		.. "╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝\n"
		.. "pwd: "
		.. vim.fn.fnamemodify(vim.fn.getcwd(), ":~:."),

	items = {
		{
			name = "File Explorer",
			action = function()
				cmd("enew")
				cmd("Explore")
			end,
			section = "Actions",
		},
		{
			name = "Lazy",
			action = function()
				cmd("Lazy")
			end,
			section = "Actions",
		},
		starter.sections.recent_files(3, false, function(path)
			-- Bring back trailing slash after `dirname`
			return " " .. vim.fn.fnamemodify(path, ":~:.:h") .. "/"
		end),
		-- starter.sections.recent_files(10, false),
		-- starter.sections.recent_files(10, true),
		-- Use this if you set up 'mini.sessions'
		starter.sections.sessions(9, true),
	},
	content_hooks = {
		starter.gen_hook.adding_bullet(),
		starter.gen_hook.aligning("center", "center"),
	},
	-- Sleeping car
	footer = "\n      |\\      _,,,---,,_\nZZZzz /,`.-'`'    -.  ;-;;,_\n     |,4-  ) )-,_. ,\\ (  `'-'\n    '---''(_/--'  `-'\\_)",
})

-- KEYMAPS

keymap("n", "<leader>pv", cmd.Ex, { desc = "Open netrw file explorer" })
keymap("n", "<leader>r", vim.lsp.buf.rename, { desc = "renames stuff with lsp" })
keymap("n", "<C-a>", "ggVG", { desc = "Selects entire document" })
keymap("i", "jk", "<Esc>", { desc = "Escapes insert mode" })
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- keymap("n", "<leader>pf", "gggqG", { desc = "formatter" })
keymap("n", "<leader>pf", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format file" })

-- sessions
keymap("n", "<leader>Ss", function()
	local name = vim.fn.input("Save session as: ")
	if name ~= "" then
		MiniSessions.write(name)
	end
end, { desc = "Save session" })

keymap("n", "<leader>Sl", function()
	local name = vim.fn.input("Load session: ")
	if name ~= "" then
		MiniSessions.read(name)
	end
end, { desc = "Loads session" })

keymap("n", "<leader>Sd", function()
	local name = vim.fn.input("Delete session: ")
	if name ~= "" then
		MiniSessions.delete(name)
	end
end, { desc = "Deletes session" })

keymap("n", "<leader>Sp", function()
	MiniSessions.read(MiniSessions.get_latest())
end, { desc = "Loads previous session" })

-- telescope
local builtin = require("telescope.builtin")
keymap("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
keymap("n", "<leader>fw", builtin.live_grep, { desc = "Telescope live grep" })
keymap("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
keymap("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

-- LOAD LAST

-- mini.notify
-- https://github.com/echasnovski/nvim/blob/master/init.lua
local predicate = function(notif)
	if not (notif.data.source == "lsp_progress" and notif.data.client_name == "lua_ls") then
		return true
	end
	-- Filter out some LSP progress notifications from 'lua_ls'
	return notif.msg:find("Diagnosing") == nil and notif.msg:find("semantic tokens") == nil
end
local custom_sort = function(notif_arr)
	return MiniNotify.default_sort(vim.tbl_filter(predicate, notif_arr))
end

require("mini.notify").setup({
	content = { sort = custom_sort },
	--    window = {
	--        config = {
	--          border = "solid",
	--          width = 80,
	--        },
	--    },
})
vim.notify = MiniNotify.make_notify()

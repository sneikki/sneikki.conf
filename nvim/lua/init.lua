local Plug = vim.fn['plug#']

vim.g.mapleader = ","
vim.g.maplocalleader = ","
vim.g.vimtex_view_method = "zathura"

vim.opt.autoread = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.number = true
vim.opt.showmatch = true
vim.opt.startofline = true
vim.opt.cursorline = true
vim.opt.wildmenu = true
vim.opt.ruler = true
vim.opt.clipboard = "unnamedplus"
vim.opt.laststatus = 2
vim.opt.confirm = true
vim.opt.shortmess = "I"
vim.opt.startofline = false

vim.call('plug#begin', '~/.config/nvim/plugged')
	-- Navigation, organizing etc.
	Plug 'junegunn/fzf'
	Plug 'junegunn/fzf.vim'
	Plug 'gcmt/taboo.vim'

	Plug('neoclide/coc.nvim', { branch = 'release' })

	Plug 'sainnhe/gruvbox-material'
	Plug 'LunarVim/horizon.nvim'
	Plug 'vv9k/vim-github-dark'
	Plug 'tomasiser/vim-code-dark' -- maybe
	Plug 'AhmedAbdulrahman/aylin.vim' -- maybe
	Plug 'bluz71/vim-nightfly-guicolors' -- maybe
	Plug 'wadackel/vim-dogrun' -- maybe
	Plug 'abra/vim-obsidian'
	Plug('sonph/onehalf', { rtp = 'vim' }) -- maybe
	Plug 'tomasr/molokai'
	Plug 'altercation/vim-colors-solarized'
	Plug 'dracula/dracula-theme'
	Plug 'chriskempson/base16-vim'
	Plug 'jnurmine/zenburn'
	Plug 'gosukiwi/vim-atom-dark'
	Plug 'NLKNguyen/papercolor-theme'
	Plug 'arcticicestudio/nord-vim' --maybe
	Plug 'connorholyday/vim-snazzy' --maybe
	Plug 'mhartington/oceanic-next' -- maybe
	Plug 'ayu-theme/ayu-vim' -- maybe
	Plug 'EdenEast/nightfox.nvim' -- maybe

	Plug 'j-hui/fidget.nvim'
	Plug 'nvim-neotest/nvim-nio'
	Plug 'tpope/vim-commentary'
	Plug 'sbdchd/neoformat'
	Plug 'dense-analysis/ale'
	-- Plug 'lepture/vim-css'
	Plug 'cakebaker/scss-syntax.vim'
	Plug 'wavded/vim-stylus'

	Plug 'shmup/vim-sql-syntax'

	Plug 'luochen1990/rainbow'
	Plug 'othree/jsdoc-syntax.vim'
	Plug 'sheerun/vim-polyglot'
	Plug 'preservim/nerdtree'

	-- Plug 'manoelcampos/xml2lua'
	-- Plug 'rest-nvim/rest.nvim'
	Plug 'rest-nvim/tree-sitter-http'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-treesitter/nvim-treesitter'

	Plug 'lervag/vimtex'

	Plug 'mfukar/robotframework-vim'

	Plug('iamcco/markdown-preview.nvim', { ['do'] = 'cd app && yarn install' })
vim.call('plug#end')

vim.opt.termguicolors = true
-- vim.opt.background = 'light'
vim.cmd("colorscheme blue")
-- vim.cmd("autocmd ColorScheme * highlight Normal guifg=#ffffff ctermfg=#ffffff")
vim.cmd("autocmd FileType scss setl iskeyword+=@-@")

local vimrcGroup = vim.api.nvim_create_augroup("vimrc", {
	clear = true
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = vimrcGroup,
	pattern = { vim.env.MYVIMRC },
	command = "source $MYVIMRC"
})

-- vim.api.nvim_create_autocmd({ "ColorScheme" }, {
-- 	group = vimrcGroup,
-- 	pattern = "*",
-- 	command = "highlight Normal guifg=white"
-- })

function get_git_branch()
	return vim.fn.system("git rev-parse --abbrev-ref HEAD 2> /dev/null | tr -d '\n'")
end

vim.opt.statusline =
	'%#CocListBlackRed#' .. ' [' .. get_git_branch() .. '] ' ..
	"%#StatusLine#" .. "  %{expand('%:p:h')}  " ..
	"%#CocListBlackGreen#" .. "  %{expand('%:t')}  " .. "%#Normal#" ..
	"%=%#StatusLine#  " .. "%p%% " .. "%l:%c " .. "%m " .. "%#CocListBlackYellow#" ..
  "%#CocListBlackYellow#" .. "  %y  "

vim.cmd('command! Q q!')
vim.cmd('command! W wq')

vim.api.nvim_set_keymap("n", "<a-b>", ":Buffers<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<a-f>", ":Files<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<a-g>", ":GFiles<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<a-r>", ":Rg<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<a-n>", ":NERDTree<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<a-c>", ":Colors<cr>", { noremap = true })

vim.api.nvim_set_keymap("n", "<c-s>", ":w<cr>", { noremap = true })

vim.api.nvim_set_keymap("n", "<c-c>", ":close<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<c-b>", ":bd<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>b!", ":bd!<cr>", { noremap = true })
-- vim.api.nvim_set_keymap("n", "<leader>c", "<Plug>RestNvim", { noremap = true })

vim.api.nvim_set_keymap("n", "<c-h>", "<c-w>h", { noremap = true })
vim.api.nvim_set_keymap("n", "<c-l>", "<c-w>l", { noremap = true })
vim.api.nvim_set_keymap("n", "<c-j>", "<c-w>j", { noremap = true })
vim.api.nvim_set_keymap("n", "<c-k>", "<c-w>k", { noremap = true })

vim.g.ctrlp_user_command = 'fd --type f'
vim.g.ctrlp_map = '<c-p>'
vim.g.ctrlp_cmd = 'CtrlPMRU .'

-- vim.g.rainbow_active = 1

vim.cmd("command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')")
-- require('rest-nvim').setup()

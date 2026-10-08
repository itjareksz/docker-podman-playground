-- =============================================
-- Init
-- =============================================

-- Disables netrw (file explorer); required by nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- =============================================
-- Keymaps
-- =============================================

-- <leader> key mapping
-- mapleader must be defined before you can use <leader> in your keymaps
vim.g.mapleader = vim.keycode("<Space>") -- space for leader
vim.g.maplocalleader = vim.keycode("<Space>") -- space for localleader

-- Other mappings
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- clear highlights on search when pressing <Esc> in normal mode

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" }) -- move line down by pressing Alt + j
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" }) -- move line up by pressing Alt + k
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" }) -- move visual selection down by pressing Alt + j
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" }) -- move visual selection up by pressing Alt + k

vim.keymap.set("n", "<leader>ss", "<cmd>set spell<CR>", { desc = "Turn on spell checker" }) -- turn on spell checker
vim.keymap.set("n", "<leader>so", "<cmd>set nospell<CR>", { desc = "Turn off spell checker" }) -- turn off spell checker

vim.keymap.set("n", "<leader>w", "<C-w>", { desc = "Window command (Ctrl+w)" }) -- use window command, equivalent to Ctrl+w

-- =============================================
-- Settings
-- =============================================

vim.opt.shell="/usr/bin/bash" -- path to terminal

vim.opt.number = true -- line numbers
vim.opt.cursorline = true -- highlight current line

vim.opt.tabstop = 4 -- tabwidth
vim.opt.shiftwidth = 4 -- indent width
vim.opt.softtabstop = 0 -- soft tab stop not tabs on tab/backspace
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.smartindent = true -- smart auto-indent
vim.opt.autoindent = true -- copy indent from current line

vim.opt.linebreak = true -- don't split words in half when wrapping at the end of a line
vim.opt.breakindent = true -- break line will continue visually indented

vim.opt.splitbelow = true -- horizontal splits go below
vim.opt.splitright = true -- vertical splits go right

vim.opt.spelllang = "en_us" -- set spell checking language

vim.opt.diffopt = "vertical" -- always use vertical split for diff

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true -- case insensitive search
vim.opt.smartcase = true -- case sensitive if uppercase in string

-- Sets how neovim will display certain whitespace characters in the editor
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- =============================================
-- Plugins
-- =============================================

-- Plugins directory: ~/.local/share/nvim

-- Example
--vim.pack.add({
--    {
--        src = "https://github.com/<plugin-name>",
--        name = "<plugin-name>",
--        version = "v0.0.0",
--    },
--})
-- Enable plugins
--<plugin-name> = require("<plugin-name>")

-- --------------------------
-- Color schemes
-- --------------------------

vim.pack.add({
    {
        src = "https://github.com/catppuccin/nvim",
        name = "catppuccin",
        version = "v2.0.0",
    },
})
require("catppuccin").setup({
    no_italic = true, -- Force no italic
})
vim.cmd.colorscheme "catppuccin-nvim"

-- --------------------------
-- nvim-tree
-- --------------------------

vim.pack.add({
    {
        src = "https://github.com/nvim-tree/nvim-tree.lua",
        name = "nvim-tree",
        version = "v1.18.0",
    },
})

---@type nvim_tree.config
local config = {
    view = {
        width = 50,
        side = "right",
    },
    renderer = {
        icons = {
            glyphs = {
                git = {
                    unstaged = "",
                    staged = "",
                    unmerged = "",
                    renamed = "",
                    untracked = "",
                    deleted = "",
                    ignored = "",
                },
            },
        },
    },
    filters = {
        git_ignored = false,
    },
}
require("nvim-tree").setup(config)

vim.keymap.set("n", "<leader>t", "<cmd>NvimTreeToggle<CR>", {desc = "File tree"})

-- --------------------------
-- mini.nvim
-- --------------------------

vim.pack.add({
    {
        src = "https://github.com/nvim-mini/mini.nvim",
        name = "mini.nvim",
        version = "v0.18.0",
    },
})

-- mini.icons
require("mini.icons").setup()

-- mini.pick - show window with picker
require("mini.pick").setup({})
-- Find keymaps
vim.keymap.set("n", "<leader>o", "<cmd>Pick buffers<CR>", {desc = "Find open buffers"})
vim.keymap.set("n", "<leader>ff", "<cmd>Pick files<CR>", {desc = "Find files in project"})
vim.keymap.set("n", "<leader>fg", "<cmd>Pick grep_live<CR>", {desc = "Find content in project files (grep live)"})
vim.keymap.set("n", "<leader>fp", "<cmd>Pick help<CR>", {desc = "Find help tags"})

-- mini.extra - additional pickers
require('mini.extra').setup()
-- Find keymaps
vim.keymap.set("n", "<leader>fc", "<cmd>Pick buf_lines scope='current'<CR>", {desc = "Find content in current file"})
vim.keymap.set("n", "<leader>fh", "<cmd>lua MiniExtra.pickers.history()<CR>", {desc = "Find in command history"})
vim.keymap.set("n", "<leader>fr", "<cmd>lua MiniExtra.pickers.oldfiles()<CR>", {desc = "Find in recent files"})
vim.keymap.set("n", "<leader>ft", "<cmd>lua MiniExtra.pickers.hipatterns()<CR>", {desc = "Find TODO, FIXME, NOTE, MARK"})
vim.keymap.set("n", "<leader>fm", "<cmd>lua MiniExtra.pickers.marks()<CR>", {desc = "Find marks (jump list)"})
-- Git keymaps
vim.keymap.set("n", "<leader>gb", "<cmd>lua MiniExtra.pickers.git_branches()<CR>", { desc = "Open Git branches list" })
vim.keymap.set("n", "<leader>gc", "<cmd>lua MiniExtra.pickers.git_commits()<CR>", { desc = "Open Git commits list" })
-- LSP keymaps
vim.keymap.set("n", "<leader>lq", "<cmd>lua MiniExtra.pickers.diagnostic()<CR>", { desc = "Open diagnostic quickfix list" })
vim.keymap.set("n", "<leader>ls", "<cmd>lua MiniExtra.pickers.lsp({ scope = 'document_symbol' })<CR>", { desc = "List document symbols in current file" })
vim.keymap.set("n", "<leader>lw", "<cmd>lua MiniExtra.pickers.lsp({ scope = 'workspace_symbol' })<CR>", { desc = "List document symbols in workspace" })
vim.keymap.set("n", "<leader>lr", "<cmd>lua MiniExtra.pickers.lsp({ scope = 'references' })<CR>", { desc = "List symbol references" })
vim.keymap.set("n", "<leader>ld", "<cmd>lua MiniExtra.pickers.lsp({ scope = 'definition' })<CR>", { desc = "List symbol definitions" })
vim.keymap.set("n", "<leader>li", vim.diagnostic.open_float, { desc = "Show line diagnostics info" }) -- show diagnostic window for problem in current line
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format local buffer" }) -- use formatter to format current buffer
vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, { desc = "Rename symbol references" }) -- rename all references to the symbol under the cursor

-- mini.clue - show window with clues about pressed specified key
local miniclue = require("mini.clue")
miniclue.setup({
    triggers = {
        -- Leader triggers
        { mode = { 'n', 'x' }, keys = '<Leader>' },

        -- `[` and `]` keys
        { mode = 'n', keys = '[' },
        { mode = 'n', keys = ']' },

        -- Built-in completion
        { mode = 'i', keys = '<C-x>' },

        -- `g` key
        { mode = { 'n', 'x' }, keys = 'g' },

        -- Marks
        { mode = { 'n', 'x' }, keys = "'" },
        { mode = { 'n', 'x' }, keys = '`' },

        -- Registers
        { mode = { 'n', 'x' }, keys = '"' },
        { mode = { 'i', 'c' }, keys = '<C-r>' },

        -- Window commands
        { mode = 'n', keys = '<C-w>' },

        -- `z` key
        { mode = { 'n', 'x' }, keys = 'z' },

        -- `d` key
        { mode = { 'n', 'x' }, keys = 'd' },
    },

    clues = {
        -- Enhance this by adding descriptions for <Leader> mapping groups
        miniclue.gen_clues.square_brackets(),
               miniclue.gen_clues.builtin_completion(),
               miniclue.gen_clues.g(),
               miniclue.gen_clues.marks(),
               miniclue.gen_clues.registers(),
               miniclue.gen_clues.windows(),
               miniclue.gen_clues.z(),

               -- Descriptions for mapping groups
               { mode = "n", keys = "<leader>f", desc = "+Find" },
               { mode = "n", keys = "<leader>s", desc = "+Spell checker" },
               { mode = "n", keys = "<leader>g", desc = "+Git" },
               { mode = "n", keys = "<leader>l", desc = "+LSP" },

               -- Descriptions for key combinations
               { mode = { "n", "x" }, keys = "dd", desc = "Delete" },
               { mode = "n", keys = "do", desc = "Diff obtain" },
               { mode = "n", keys = "dp", desc = "Diff push" },
    },

    -- Clue window settings
    window = {
        -- Delay before showing clue window
        delay = 0,

        -- Floating window config
        config = {
            -- Compute window width automatically
            width = "auto",
        },

        -- Keys to scroll inside the clue window
        scroll_down = '<C-f>',
        scroll_up = '<C-b>',
    },
})

-- mini.completion - show more information on auto-completion
vim.opt.complete = ".,w,b"  -- complete for this sources: dot, word, buffer
vim.opt.completeopt = "menuone,noselect,fuzzy" -- autocompletion options
-- mini.completion first insert LSP suggestion, to enter words from file press <Ctrl>+<Space>
require("mini.completion").setup()

-- mini.indentscope - show animated indent line
require("mini.indentscope").setup()

-- Git integration
require("mini.git").setup()
require("mini.diff").setup()
vim.keymap.set("n", "<leader>gh", "<cmd>Git log --graph --oneline --all<CR>", { desc = "Open Git history" })
vim.keymap.set("n", "<leader>gr", "<cmd>lua MiniGit.show_at_cursor()<CR>", { desc = "Open Git related data at cursor" })

-- mini.statusline - better status line
require("mini.statusline").setup()

-- mini.hipatterns - highlight patterns in text
local hipatterns = require("mini.hipatterns")
hipatterns.setup({
    highlighters = {
        -- Highlight standalone 'FIXME', 'MARK', 'TODO', 'NOTE'
fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
                 mark  = { pattern = "%f[%w]()MARK()%f[%W]",  group = "MiniHipatternsHack"  },
                 todo  = { pattern = "%f[%w]()TODO()%f[%W]",  group = "MiniHipatternsTodo"  },
                 note  = { pattern = "%f[%w]()NOTE()%f[%W]",  group = "MiniHipatternsNote"  },

                 -- Highlight hex color strings (`#rrggbb`) using that color
                 hex_color = hipatterns.gen_highlighter.hex_color(),
    },
})

-- mini.files - files explorer
require("mini.files").setup()
vim.keymap.set("n", "<leader>e", "<cmd>lua MiniFiles.open()<CR>", { desc = "File explorer" })

-- --------------------------
-- ale - linter
-- --------------------------

vim.pack.add({
   {
       src = "https://github.com/dense-analysis/ale",
       name = "ale",
       version = "v4.0.0",
   },
})
vim.g.ale_virtualtext_cursor = "disabled"

-- --------------------------
-- conform.nvim - formatter
-- --------------------------

vim.pack.add({
    {
        src = "https://github.com/stevearc/conform.nvim",
        name = "conform",
        version = "v9.1.0",
    },
})
require("conform").setup({
    formatters_by_ft = {
        markdown = { "prettier" },
        sh = { lsp_format = "fallback" },
        yaml = { lsp_format = "fallback" },
        ["ansible.yaml"] = { "prettier" },
    },
})

-- =============================================
-- LSP
-- =============================================

-- Check if LSP is working with command:
-- :checkhealth vim.lsp

-- bash-language-server
vim.lsp.config["bash-language-server"] = {
    cmd = { "bash-language-server", "start" },
    filetypes = { "sh" },
}
vim.lsp.enable("bash-language-server")

-- ansible-language-server
vim.filetype.add({
    pattern = {
        [".*ansible.ya?ml"] = "ansible.yaml",
    },
})

vim.lsp.config["ansible-language-server"] = {
    cmd = { "ansible-language-server", "--stdio" },
    filetypes = { "ansible.yaml" },
}
vim.lsp.enable("ansible-language-server")

-- yaml-language-server
vim.lsp.config["yaml-language-server"] = {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml", "yml" },
    settings = {
        -- Disable telemetry
        redhat = { telemetry = { enabled = false } },
        -- Formatting disabled by default in yaml-language-server; enable it
        yaml = {
            format = { enable = true },
            schemas = {
                ["kubernetes"] = { "*.k8s.yaml", "k8s/*.yaml", "k8s/*.yml"},
            },
        },
    },
}
vim.lsp.enable("yaml-language-server")

-- dockerfile-language-server
vim.lsp.config("dockerfile-language-server", {
    cmd = { "docker-langserver", "--stdio" },
    filetypes = { "dockerfile" },
})
vim.lsp.enable("dockerfile-language-server")

-- markdown-language-server
vim.lsp.config("markdown-language-server", {
    cmd = { "markdown-oxide" },
    filetypes = { "markdown" },
})
vim.lsp.enable("markdown-language-server")

-- =============================================
-- Autocommands
-- =============================================

-- Format on save using conform.nvim
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
    require("conform").format({ bufnr = args.buf })
    end,
})

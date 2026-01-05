-- Disable polyglot for typescript
vim.g.polyglot_disabled = {'typescript'}

-- Bootstrap lazy.nvim
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

-- Plugin management with lazy.nvim
require("lazy").setup({
  'ishan9299/nvim-solarized-lua',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',
  'leafgarland/typescript-vim',
  'Raimondi/delimitMate',
  'numToStr/Comment.nvim',
  'nvim-lualine/lualine.nvim',
  'kylechui/nvim-surround',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-vsnip',
  'hrsh7th/vim-vsnip',
  'javiorfo/nvim-soil',
  'javiorfo/nvim-nyctophilia',
  { 'iamcco/markdown-preview.nvim', build = 'cd app && yarn install' },
  'nvim-lua/plenary.nvim',
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x' },
  {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
          require'nvim-treesitter.config'.setup {
              ensure_installed = {
                  "lua", "vim", "vimdoc",
                  "javascript", "typescript",
                  "java", "go", "python",
                  "bash", "dockerfile",
                  "markdown", "markdown_inline",
                  "html", "yaml"
              },
              auto_install = true,
              highlight = {
                  enable = true,
                  additional_vim_regex_highlighting = false,
              },
              indent = {
                  enable = true,
              },
          }
      end,
  },
  'nvim-tree/nvim-web-devicons',
  'nvim-tree/nvim-tree.lua',
  'stevearc/dressing.nvim',
  'ziontee113/icon-picker.nvim',
  'mzlogin/vim-markdown-toc',
  'folke/trouble.nvim',
  'MeanderingProgrammer/render-markdown.nvim',
  'olimorris/codecompanion.nvim',
})

-- Load environment variables
for key, value in pairs(require('env')) do
    vim.env[key] = value
end

-- Leader key
vim.g.mapleader = ','

-- Basic settings
vim.opt.fillchars = 'eob: '
vim.opt.termguicolors = true
vim.opt.background = 'light'
vim.opt.wrap = true
vim.opt.textwidth = 80
vim.opt.cmdheight = 1
vim.opt.laststatus = 3
vim.opt.scrolloff = 3
vim.opt.cursorline = true
vim.opt.cindent = true
vim.opt.autoindent = true
vim.opt.showcmd = true
vim.opt.ruler = true
vim.opt.rulerformat = '%30(%=\\:b%n%y%m%r%w\\ %l,%c%V\\ %P%)'
vim.opt.visualbell = true
vim.opt.backup = false
vim.opt.number = true
vim.opt.title = true
vim.opt.ttyfast = true
vim.opt.modeline = true
vim.opt.modelines = 3
vim.opt.shortmess = 'atI'
vim.opt.startofline = false
vim.opt.backspace = 'indent,eol,start'
vim.opt.matchpairs:append('<:>')
vim.opt.showmatch = true
vim.opt.matchtime = 3
vim.opt.mouse = ''
vim.opt.history = 500
vim.opt.signcolumn = 'number'
vim.opt.colorcolumn = '80'
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.directory = vim.fn.expand('~/.vim/tmp')
vim.opt.tags = './.ctags'
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.spelllang = 'en_us'
vim.opt.spell = true

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Enable syntax and filetype
vim.cmd('syntax on')
vim.cmd('filetype plugin indent on')

-- ==================================================
-- Plugin configurations
-- ==================================================

require("codecompanion").setup({
    interactions = {
        chat = {
            adapter = "anthropic",
            model = "claude-sonnet-4-20250514"
        },
    },
    opts = {
        log_level = "DEBUG",
    },
})

require('render-markdown').setup({
    file_types = { 'markdown', 'codecompanion' },
})

require("nvim-tree").setup({
    on_attach = function (bufnr)
        local api = require "nvim-tree.api"

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

        local function clear_and_copy()
            api.fs.clear_clipboard()
            api.fs.copy.node()
        end

        local function clear_and_cut()
            api.fs.clear_clipboard()
            api.fs.cut()
        end

        vim.keymap.set('n', 'c', clear_and_copy, opts('Copy'))
        vim.keymap.set('n', 'x', clear_and_cut, opts('Cut'))
    end,
    sort_by = "case_sensitive",
    view = {
        width = 30,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = false,
    },
    git = {
        ignore = false
    },
})

require("nvim-surround").setup({})

-- Set up nvim-cmp
local cmp = require'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
    }, {
        { name = 'buffer' },
    })
})

-- Set configuration for specific filetype
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' },
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?`
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

require("mason").setup()
require("mason-lspconfig").setup()

-- Set up lspconfig
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lspList = {
    "tailwindcss",
    "ts_ls",
    "solidity_ls_nomicfoundation",
    "rust_analyzer",
    "pyright",
    "html",
    "dockerls",
    "cssls",
    "bashls",
    "marksman",
}

for _, lspName in pairs(lspList) do
    vim.lsp.config(lspName, { capabilities = capabilities })
    vim.lsp.enable({lspName})
end

require('mason-lspconfig').setup({
    ensure_installed = lspList
})

-- Telescope setup
require('telescope').setup({
    defaults = {
        layout_config = {
            prompt_position = 'top'
        },
        mappings = {
            i = {
                ["<ESC>"] = "close",
            },
            n = {
                ["q"] = "close",
            },
        },
    },
    pickers = {
        lsp_references = {
            initial_mode = 'normal',
        },
        buffers = {
            initial_mode = 'normal',
            theme = 'dropdown',
            mappings = {
                n = {
                    ["d"] = "delete_buffer",
                },
            },
        },
    },
})

-- Web devicons setup
require'nvim-web-devicons'.setup {
    override = {
        zsh = {
            icon = "",
            color = "#428850",
            cterm_color = "65",
            name = "Zsh"
        }
    };
    color_icons = true;
    default = true;
    strict = true;
    override_by_filename = {
        [".gitignore"] = {
            icon = "",
            color = "#f1502f",
            name = "Gitignore"
        }
    };
    override_by_extension = {
        ["log"] = {
            icon = "",
            color = "#81e043",
            name = "Log"
        }
    };
}

require('Comment').setup()
require("icon-picker").setup({ disable_legacy_commands = true })

require('lualine').setup {
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff'},
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = {'diagnostics', 'filetype',},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    }
}

require('trouble').setup()

-- Color scheme
vim.cmd('colorscheme solarized')

-- Highlight settings
vim.cmd([[
highlight WhitespaceEOL ctermbg=red guibg=red
highlight MatchParen ctermbg=blue
match WhitespaceEOL /\s\+$/
]])

-- GUI settings
if vim.fn.has("gui_running") == 1 then
    vim.opt.lines = 75
    vim.opt.columns = 180
end

-- ==================================================
-- Key mappings
-- ==================================================

-- Basic mappings
vim.keymap.set('i', 'jj', '<Esc>', {})
vim.keymap.set('c', 'jj', '<C-c>', {})
vim.keymap.set('', '<C-c>', '<Nop>', {})
vim.keymap.set('i', '<C-c>', '<Nop>', {})

-- vimrc handling
vim.keymap.set('n', '<leader>v', ':sp ~/.config/nvim/init.lua<CR><C-W>_', {})
vim.keymap.set('n', '<leader>V', ':source ~/.config/nvim/init.lua<CR>:filetype detect<CR>:echo "vimrc reloaded"<CR>', { silent = true })

-- Search settings
vim.keymap.set('n', '<F4>', ':set hlsearch! hlsearch?<CR>', { noremap = true })

-- Trailing whitespace
vim.keymap.set('n', '<leader>S', function()
    local save = vim.fn.getreg('/')
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setreg('/', save)
    vim.cmd('nohlsearch')
end, { silent = true })

-- Window navigation
vim.keymap.set('n', '<C-J>', '<C-w>j', { noremap = true })
vim.keymap.set('n', '<C-K>', '<C-w>k', { noremap = true })
vim.keymap.set('n', '<C-H>', '<C-w>h', { noremap = true })
vim.keymap.set('n', '<C-L>', '<C-w>l', { noremap = true })
vim.keymap.set('n', '<C-Down>', '<C-W>j', { noremap = true })
vim.keymap.set('n', '<C-Up>', '<C-W>k', { noremap = true })
vim.keymap.set('n', '<C-Left>', '<C-W>h', { noremap = true })
vim.keymap.set('n', '<C-Right>', '<C-W>l', { noremap = true })

-- Splits handling
vim.keymap.set('i', '<C-W>', '<C-O><C-W>', {})
vim.keymap.set('n', '-', '<C-W>-', {})
vim.keymap.set('n', '+', '<C-W>+', {})
vim.keymap.set('n', '<M-,>', '<C-W>>', {})
vim.keymap.set('n', '<M-.>', '<C-W><', {})
vim.keymap.set('n', ',', '<C-W>>', {})
vim.keymap.set('n', '.', '<C-W><', {})
vim.keymap.set('n', '<F2>', '<Esc>:close<CR><Esc>', { noremap = true })

-- Right-to-Left shortcuts
vim.keymap.set('n', '<F9>', ':set invrl<CR>', {})
vim.keymap.set('i', '<F9>', '<Esc>:set invrl<CR>a', {})
vim.keymap.set('n', '<F8>', ':set invrevins<CR>', {})
vim.keymap.set('i', '<F8>', '<Esc>:set invrevins<CR>a', {})

-- Tab key mappings
vim.keymap.set('n', '<TAB>', '>>', {})
vim.keymap.set('n', '<S-TAB>', '<<', {})
vim.keymap.set('v', '<TAB>', '>', {})
vim.keymap.set('v', '<S-TAB>', '<', {})

-- Home key mappings
vim.keymap.set('i', '<HOME>', '<Esc>^i', {})
vim.keymap.set('n', '<HOME>', '^', {})

-- Plugin-specific keymaps
vim.keymap.set('n', '<F3>', require'nvim-tree.api'.tree.toggle, {})
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {})
vim.keymap.set('i', '<C-e>', '<cmd>IconPickerInsert emoji<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>d', '<cmd>Trouble diagnostics<cr>', { noremap = true, silent = true })

-- Telescope keymaps
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-g>', builtin.live_grep, {})
vim.keymap.set('n', '<leader><leader>', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<F12>', builtin.lsp_definitions, {})
vim.keymap.set('n', '<leader><F12>', builtin.lsp_references, {})

-- ==================================================
-- Autocmds
-- ==================================================

-- Filetype-specific settings
local function create_filetype_autocmds()
    local group = vim.api.nvim_create_augroup('FiletypeSettings', { clear = true })

    local filetypes = {
        'html', 'xhtml', 'xml', 'css', 'less', 'ruby', 'javascript'
    }

    for _, ft in ipairs(filetypes) do
        vim.api.nvim_create_autocmd('FileType', {
            group = group,
            pattern = ft,
            callback = function()
                vim.opt_local.tabstop = 4
                vim.opt_local.shiftwidth = 4
                vim.opt_local.expandtab = true
                if ft == 'javascript' then
                    vim.opt_local.softtabstop = 0
                end
            end
        })
    end
end

-- React filetypes
local function create_react_autocmds()
    local group = vim.api.nvim_create_augroup('ReactFiletypes', { clear = true })

    vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
        group = group,
        pattern = '*.jsx',
        callback = function()
            vim.bo.filetype = 'javascriptreact'
        end
    })

    vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
        group = group,
        pattern = '*.tsx',
        callback = function()
            vim.bo.filetype = 'typescriptreact'
        end
    })
end

create_filetype_autocmds()
create_react_autocmds()


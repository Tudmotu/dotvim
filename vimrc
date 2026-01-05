set nocompatible
filetype off

let g:polyglot_disabled = ['typescript']

call plug#begin('~/.vim/plugged')

Plug 'ishan9299/nvim-solarized-lua'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'leafgarland/typescript-vim'
Plug 'Raimondi/delimitMate'
Plug 'numToStr/Comment.nvim'
Plug 'nvim-lualine/lualine.nvim'
" Plug 'bling/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'kylechui/nvim-surround'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'javiorfo/nvim-soil'
Plug 'javiorfo/nvim-nyctophilia'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'stevearc/dressing.nvim'
Plug 'ziontee113/icon-picker.nvim'
Plug 'mzlogin/vim-markdown-toc'
Plug 'folke/trouble.nvim'

call plug#end()

lua << EOF
    vim.g.mapleader = ','
    vim.opt.fillchars='eob: '

    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- set termguicolors to enable highlight groups
    vim.opt.termguicolors = true

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

    vim.keymap.set('n', '<F3>', require'nvim-tree.api'.tree.toggle, {})


    require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
    })

    -- Set up nvim-cmp.
    local cmp = require'cmp'

    cmp.setup({
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            end,
        },
        window = {
            -- completion = cmp.config.window.bordered(),
            -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
        }, {
            { name = 'buffer' },
        })
    })

    -- Set configuration for specific filetype.
    cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
        }, {
            { name = 'buffer' },
        })
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
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

    -- Set up lspconfig.
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.

    lspList = {
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

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<C-p>', builtin.find_files, {})
    vim.keymap.set('n', '<C-g>', builtin.live_grep, {})
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    vim.keymap.set('n', '<F12>', builtin.lsp_definitions, {})
    vim.keymap.set('n', '<leader><F12>', builtin.lsp_references, {})

    require'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all" (the five listed parsers should always be installed)
        ensure_installed = { "lua", "vim", "vimdoc", "javascript", "typescript",
            "java", "go", "python", "groovy", "rst", "bash", "dockerfile",
            "markdown", "markdown_inline"},

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = false,

        highlight = {
            enable = true,
        },
    }

    require'nvim-web-devicons'.setup {
        -- your personnal icons can go here (to override)
        -- you can specify color or cterm_color instead of specifying both of them
        -- DevIcon will be appended to `name`
        override = {
            zsh = {
                icon = "",
                color = "#428850",
                cterm_color = "65",
                name = "Zsh"
            }
            };
        -- globally enable different highlight colors per icon (default to true)
        -- if set to false all icons will have the default icon's color
        color_icons = true;
        -- globally enable default icons (default to false)
        -- will get overriden by `get_icons` option
        default = true;
        -- globally enable "strict" selection of icons - icon will be looked up in
        -- different tables, first by filename, and if not found by extension; this
        -- prevents cases when file doesn't have any extension but still gets some icon
        -- because its name happened to match some extension (default to false)
        strict = true;
        -- same as `override` but specifically for overrides by filename
        -- takes effect when `strict` is true
        override_by_filename = {
            [".gitignore"] = {
                icon = "",
                color = "#f1502f",
                name = "Gitignore"
            }
            };
        -- same as `override` but specifically for overrides by extension
        -- takes effect when `strict` is true
        override_by_extension = {
            ["log"] = {
                icon = "",
                color = "#81e043",
                name = "Log"
            }
            };
    }

    require('Comment').setup()

    vim.cmd('colorscheme solarized')
    vim.opt.signcolumn = 'number'
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {})

    require("icon-picker").setup({ disable_legacy_commands = true })
    vim.keymap.set("i", "<C-e>", "<cmd>IconPickerInsert emoji<cr>", { noremap = true, silent = true })

    vim.opt.spelllang = 'en_us'
    vim.opt.spell = true

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
    vim.keymap.set("n", "<leader>d", "<cmd>Trouble diagnostics<cr>", { noremap = true, silent = true })
EOF

" ==================================================
" Color scheme and fonts
" ==================================================
set termguicolors
set background=light

" ==================================================
" Basic Settings
" ==================================================
let mapleader=","       " change the leader to be a comma vs slash
set wrap
set textwidth=80        " Try this out to see how textwidth helps
set ch=1                " Make command line two lines high
set ls=2                " allways show status line
set scrolloff=3         " keep 3 lines when scrolling
set cursorline          " have a line indicate the cursor location
set cindent             " cindent
set autoindent          " always set autoindenting on
set showcmd             " display incomplete commands
set ruler               " show the cursor position all the time
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
set visualbell
set nobackup            " do not keep a backup file
set number              " show line numbers
set title               " show title in console title bar
set ttyfast             " smoother changes
set modeline            " last lines in document sets vim mode
set modelines=3         " number lines checked for modelines
set shortmess=atI       " Abbreviate messages
set nostartofline       " don't jump to first character when paging
set backspace=indent,eol,start
set matchpairs+=<:>     " show matching <> (html mainly) as well
set showmatch
set matchtime=3
set sm                  " show matching braces, somewhat annoying...
set mouse=
set history=500         " larger history


set statusline=%<%f\                     " Filename
set statusline+=%w%h%m%r                 " Options
set statusline+=\ [%{&ff}/%Y]            " filetype
set statusline+=\ [%{getcwd()}]          " current dir
set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
set laststatus=3

" Columns and lines
set colorcolumn=80

if has("gui_running")
    set lines=75
    set columns=180
endif

" Tab expanded to 4 spaces
set tabstop=4           " numbers of spaces of tab character
set shiftwidth=4        " numbers of spaces to (auto)indent
set expandtab		    " Tab to spaces by default
set softtabstop=4

" Keep swap files out of the working dir
" Adjust if needed in another dir
set directory=~/.vim/tmp

syntax on
filetype plugin on
filetype indent plugin on

" Tell vim to automatically look for tag files
"set tags=./tags,tags;$HOME
set tags=./.ctags


" ==================================================
" Basic Mappings
" ==================================================

" Maps for jj to act as Esc in insert and command modes
ino jj <esc>
cno jj <c-c>

" One can map ctrl-c to something else if needed
map <c-c> <Nop>
imap <c-c> <Nop>

" ==================================================
" vimrc handling
" ==================================================

" ,v loads .vimrc
" ,V reloads .vimrc -- activating changes (needs save)
map <leader>v :sp ~/.vimrc<CR><C-W>_
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" ==================================================
" Search settings
" ==================================================

set hlsearch    " highlight searches
set incsearch   " do incremental searching
set ignorecase  " ignore case when searching
set smartcase   " if searching and search contains upper case, make case sensitive search

" Press F4 to toggle highlighting on/off, and show current value.
noremap <F4> :set hlsearch! hlsearch?<CR>


" ==================================================
" Trailing whitespace handling
" ==================================================

" Highlight end of line whitespace.
highlight WhitespaceEOL ctermbg=red guibg=red
highlight MatchParen ctermbg=blue
match WhitespaceEOL /\s\+$/

" Clean all end of line extra whitespace with ,S
:nnoremap <silent><leader>S :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" ==================================================
" Window navigation
" ==================================================

" control + vim direction key to navigate windows
noremap <C-J> <C-w>j
noremap <C-K> <C-w>k
noremap <C-H> <C-w>h
noremap <C-L> <C-w>l

" control + arrow key to navigate windows
noremap <C-Down> <C-W>j
noremap <C-Up> <C-W>k
noremap <C-Left> <C-W>h
noremap <C-Right> <C-W>l


" ==================================================
" Splits handling
" ==================================================

" Make these all work in insert mode
imap <C-W> <C-O><C-W>

" - and + to resize horizontal splits
map - <C-W>-
map + <C-W>+

" alt-< or alt-> for vertical splits
map <m-,> <C-W>>
map <m-.> <C-W><

" And for gnome terminal etc
map , <C-W>>
map . <C-W><

" F2 close current split (window)
noremap <F2> <Esc>:close<CR><Esc>


" ==================================================
" Right-to-Left (Hebrew etc) shortcuts
" ==================================================

" toggle direction mapping
" this is useful for logical-order editing
map <F9>   :set invrl<CR>
" do it when in insert mode as well (and return to insert mode)
imap <F9> <Esc>:set invrl<CR>a

" toggle reverse insertion
" this is useful for visual-order editing
map <F8>   :set invrevins<CR>
" do it when in insert mode as well (and return to insert mode)
imap <F8> <Esc>:set invrevins<CR>a



" ==================================================
" FileType and Indentation settings
" ==================================================
" tab expansion
autocmd Filetype html setlocal ts=4 sw=4 expandtab
autocmd Filetype xhtml setlocal ts=4 sw=4 expandtab
autocmd Filetype xml setlocal ts=4 sw=4 expandtab
autocmd Filetype css setlocal ts=4 sw=4 expandtab
autocmd Filetype less setlocal ts=4 sw=4 expandtab
autocmd Filetype ruby setlocal ts=4 sw=4 expandtab
autocmd Filetype javascript setlocal ts=4 sw=4 sts=0 expandtab

augroup ReactFiletypes
  autocmd!
  autocmd BufRead,BufNewFile *.jsx set filetype=javascriptreact
  autocmd BufRead,BufNewFile *.tsx set filetype=typescriptreact
augroup END

" ==================================================
" Tab Key Mappings
" ==================================================

nmap <TAB> >>
nmap <S-TAB> <<
vmap <TAB> >
vmap <S-TAB> <

" ==================================================
" Home Key Mappings
" ==================================================

imap <HOME> <Esc>^i
nmap <HOME> ^

" ==================================================
" vim-airline
" ==================================================

" let g:airline_powerline_fonts = 1
" let g:Powerline_symbols = 'unicode'
" let g:airline_skip_empty_sections = 1
" let g:airline#extensions#tabline#enabled = 1

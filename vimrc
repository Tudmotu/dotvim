set nocompatible
filetype off

let g:polyglot_disabled = ['typescript']

call plug#begin('~/.vim/plugged')

Plug 'sheerun/vim-polyglot'
Plug 'leafgarland/typescript-vim'
Plug 'Raimondi/delimitMate'
Plug 'preservim/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'bling/vim-airline'
Plug 'kylechui/nvim-surround'
Plug 'lifepillar/vim-solarized8'
Plug 'Shougo/unite.vim'
Plug 'MordechaiHadad/nvim-lspmanager' | Plug 'neovim/nvim-lspconfig'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

call plug#end()

lua << EOF
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

    -- Set up lspconfig.
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.

    lspList = {
        "tsserver",
        "solang",
        "pyright",
        "html",
        "dockerls",
        "cssls",
        "bashls",
    }

    for _, lspName in pairs(lspList) do
        require('lspconfig')[lspName].setup { capabilities = capabilities }
    end

    require('lspmanager').setup({
        ensure_installed = lspList
    })
EOF

" ==================================================
" Color scheme and fonts
" ==================================================
set termguicolors
set background=light
autocmd vimenter * ++nested colorscheme solarized8
colorscheme solarized8

" ==================================================
" Basic Settings
" ==================================================
let mapleader=","       " change the leader to be a comma vs slash
set wrap
set textwidth=80        " Try this out to see how textwidth helps
set ch=2                " Make command line two lines high
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
set mouse=a
set history=500         " larger history


set statusline=%<%f\                     " Filename
set statusline+=%w%h%m%r                 " Options
set statusline+=\ [%{&ff}/%Y]            " filetype
set statusline+=\ [%{getcwd()}]          " current dir
set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info

set wildmenu                             " show list instead of just completing
set wildmode=list:longest,full           " command <Tab> completion, list matches, then longest common part, then all.
set completeopt=menu                     " Just show the menu upon completion (faster)

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

" <C-TAB> and <C-S-TAB> to switch buffers " in the current window
noremap <C-TAB> :MBEbn<CR>
noremap <C-S-TAB> :MBEbp<CR>
"
" Or, in MRU fashion
"
"noremap <C-TAB> :MBEbf<CR>
"noremap <C-S-TAB> :MBEbb<CR>


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

" define less filetype
au BufNewFile,BufRead *.less set filetype=less

" make the smarty .tpl files html files for our purposes
au BufNewFile,BufRead *.tpl set filetype=html

" json
au! BufRead,BufNewFile *.json set filetype=json

" jquery
au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery

" velocity
au! BufRead,BufNewFile *.vm set filetype=velocity

" mustache
au! BufRead,BufNewFile *.mustache set filetype=html
au! BufRead,BufNewFile *.ms set filetype=html
hi def link mustacheInside Identifier
hi def link mustacheSection Conditional
hi def link mustacheUnescape String

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
" NERDTree
" ==================================================

let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
map <F3> :NERDTreeToggle<CR>

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

let g:airline_powerline_fonts = 1
let g:Powerline_symbols = 'unicode'
" let g:airline#extensions#tabline#enabled = 1

" ==================================================
" vim-easytags
" ==================================================

"let g:easytags_always_enabled = 1
let g:easytags_auto_highlight = 0
let g:easytags_syntax_keyword = 'always'
let g:easytags_async = 1
let g:easytags_dynamic_files = 1

" ==================================================
" unite.vim
" ==================================================
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <C-p> :<C-u>Unite -buffer-name=files -start-insert file_rec<cr>
nnoremap <leader>y :<C-u>Unite -buffer-name=yank history/yank<cr>
nnoremap <leader><leader> :<C-u>Unite -buffer-name=buffer buffer<cr>

" ==================================================
" coq_nvim
" ==================================================
let g:coq_settings = { 'auto_start': 'shut-up' }

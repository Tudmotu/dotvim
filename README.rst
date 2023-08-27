============================================================
My neovim setup
============================================================

Main Features
============

* Plugin manager is vim-plug_
* Colorscheme is Solarized Light via nvim-solarized-lua_
* Fully configured lspconfig using mason.vim_ and mason-lspconfig.nvim_
* Uses telescope.nvim_ with some simple configuration options
* vim-airline_
* NvimTree_ including icons via nvim-web-devicons_ (requires a patched NerdFont_)
* Enchanced syntax highlighting using Treesitter_
* Emoji picker using icon-picker.nvim_
* Remap ``<Leader>`` to ``,`` and ``jj`` to ``<ESC>``

.. _nvim-solarized-lua: https://github.com/ishan9299/nvim-solarized-lua
.. _vim-plug: https://github.com/junegunn/vim-plug
.. _mason.vim: https://github.com/williamboman/mason.nvim
.. _mason-lspconfig.nvim: https://github.com/williamboman/mason-lspconfig.nvim
.. _telescope.nvim: https://github.com/nvim-telescope/telescope.nvim
.. _vim-airline: https://github.com/vim-airline/vim-airline
.. _NvimTree: https://github.com/nvim-tree/nvim-tree.lua
.. _NerdFont: https://www.nerdfonts.com/
.. _Treesitter: https://github.com/nvim-treesitter/nvim-treesitter
.. _icon-picker.nvim: https://github.com/ziontee113/icon-picker.nvim
.. _nvim-web-devicons: https://github.com/nvim-tree/nvim-web-devicons

Usage
============

The following commands will clone the repo, symlink `~/.vimrc` and update the
bundles::

    git clone https://github.com/Tudmotu/dotvim.git ~/.vim
    ln -s ~/.vim/vimrc ~/.vimrc
    cd ~/.vim

To add or override settings, place them in ``~/.vim/vimrc.local``.

To install plugins using Plug::

    :PlugInstall


Shortcuts and re-Mappings
============================

================================  =================================================================
Key                               Command
================================  =================================================================
``jj``                            ``<Esc>`` in insert and command modes
--------------------------------  -----------------------------------------------------------------
``,``                             ``<Leader>``
--------------------------------  -----------------------------------------------------------------
``<CTRL-P>``                      Open Telescope file finder
--------------------------------  -----------------------------------------------------------------
``<CTRL-G>``                      Open Telescope grep search
--------------------------------  -----------------------------------------------------------------
``,,``                            Open Telescope buffer picker
--------------------------------  -----------------------------------------------------------------
``<ESC>`` in Telescope            Close the Telescope pane
--------------------------------  -----------------------------------------------------------------
``<d>`` in buffers picker         Delete buffer under cursor
--------------------------------  -----------------------------------------------------------------
``<C-i>`` in insert mode          Open emoji picker
--------------------------------  -----------------------------------------------------------------
``<Leader>v``                     Load `.vimrc`
--------------------------------  -----------------------------------------------------------------
``<Leader>V``                     Activate changes to `.vimrc` (Make sure to save it before)
--------------------------------  -----------------------------------------------------------------
``<F2>``                          Close current split (window)
--------------------------------  -----------------------------------------------------------------
``<F3>``                          Toggle file tree
--------------------------------  -----------------------------------------------------------------
``<F4>``                          Toggle search highlight
--------------------------------  -----------------------------------------------------------------
``<Leader>S``                     Remove trailing whitespace
--------------------------------  -----------------------------------------------------------------
``<CTRL>hjkl``                    Window movement commands (mapped via MiniBufExplorer settings)
--------------------------------  -----------------------------------------------------------------
``<CTRL>arrow``                   Window movement commands (mapped via MiniBufExplorer settings)
--------------------------------  -----------------------------------------------------------------
``-``, ``+``                      Resize horizontal splits
--------------------------------  -----------------------------------------------------------------
``<ALT><`` ``<ALT>>``             Resize vertical splits
--------------------------------  -----------------------------------------------------------------
``<F9>``                          Toggle logical (RTL, e.g: Hebrew) editing
--------------------------------  -----------------------------------------------------------------
``<F8>``                          Toggle visual (RTL, e.g: Hebrew) editing
--------------------------------  -----------------------------------------------------------------
``<TAB>``                         Indent line in visual and normal modes
--------------------------------  -----------------------------------------------------------------
``<S-TAB>``                       Unindent line in visual and normal modes
--------------------------------  -----------------------------------------------------------------
``<HOME>``                        'Soft-Home' (first non-white-space character)
================================  =================================================================

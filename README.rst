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
* Remap ``<Leader>`` to ``,`` and ``jj`` to ``<ESC>``

.. _nvim-solarized-lua link: https://github.com/ishan9299/nvim-solarized-lua
.. _vim-plug link: https://github.com/junegunn/vim-plug
.. _mason.vim link: https://github.com/williamboman/mason.nvim
.. _mason-lspconfig link: https://github.com/williamboman/mason-lspconfig.nvim
.. _telescope.nvim link: https://github.com/nvim-telescope/telescope.nvim
.. _vim-airline link: https://github.com/vim-airline/vim-airline
.. _NvimTree link: https://github.com/nvim-tree/nvim-tree.lua
.. _NerdFont link: https://www.nerdfonts.com/
.. _Treesitter link: https://github.com/nvim-treesitter/nvim-treesitter
.. _nvim-web-devicons link: https://github.com/nvim-tree/nvim-web-devicons

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

======================  =================================================================
Key                     Command
======================  =================================================================
``jj``                  ``<Esc>`` in insert and command modes
----------------------  -----------------------------------------------------------------
``,``                   ``<Leader>``
----------------------  -----------------------------------------------------------------
``<CTRL-P>``            Open Telescope file finder
----------------------  -----------------------------------------------------------------
``<CTRL-G>``            Open Telescope grep search
----------------------  -----------------------------------------------------------------
``,,``                  Open Telescope buffer viewer
----------------------  -----------------------------------------------------------------
``<ESC>`` in Telescope  Close the Telescope pane
----------------------  -----------------------------------------------------------------
``<Leader>v``           Load `.vimrc`
----------------------  -----------------------------------------------------------------
``<Leader>V``           Activate changes to `.vimrc` (Make sure to save it before)
----------------------  -----------------------------------------------------------------
``<F2>``                Close current split (window)
----------------------  -----------------------------------------------------------------
``<F3>``                Toggle file tree
----------------------  -----------------------------------------------------------------
``<F4>``                Toggle search highlight
----------------------  -----------------------------------------------------------------
``<Leader>S``           Remove trailing whitespace
----------------------  -----------------------------------------------------------------
``<CTRL>hjkl``          Window movement commands (mapped via MiniBufExplorer settings)
----------------------  -----------------------------------------------------------------
``<CTRL>arrow``         Window movement commands (mapped via MiniBufExplorer settings)
----------------------  -----------------------------------------------------------------
``-``, ``+``            Resize horizontal splits
----------------------  -----------------------------------------------------------------
``<ALT><`` ``<ALT>>``   Resize vertical splits
----------------------  -----------------------------------------------------------------
``<F9>``                Toggle logical (RTL, e.g: Hebrew) editing
----------------------  -----------------------------------------------------------------
``<F8>``                Toggle visual (RTL, e.g: Hebrew) editing
----------------------  -----------------------------------------------------------------
``<TAB>``               Indent line in visual and normal modes
----------------------  -----------------------------------------------------------------
``<S-TAB>``             Unindent line in visual and normal modes
----------------------  -----------------------------------------------------------------
``<HOME>``              'Soft-Home' (first non-white-space character)
======================  =================================================================

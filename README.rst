============================================================
My vim setup
============================================================

My vim IDE setup for python, html, css, javascript, gettext and more.

Forked from Meir Kriheli's dotvim_.

.. _dotvim: https://github.com/MeirKriheli/dotvim

Features
============

* `vimrc` handling
* Incremental and smart case search.
* Trailing whitespace highlightling and cleaning shortcut.
* Logical and Visual layout (for Right-To-Left lanaguegs) editing.
* Tabs expand to 4 spaces by default
* Remap ```<Leader>`` to ``,`` and ``jj` to ``<ESC>``
* Highlight current row and color column 80
* Extra syntax highlighting (css3, less, json, jinja, jquery, velocity
  templates, angular templates, etc)
* Syntax checking
* Snippets
* Python completion, refactoring, navigation and docs
* Quotes, parens etc pair, surround
* Extended pair matching with %
* ASCII drawing
* Fuzzy file, buffer, mru, tag, etc finder
* VCS plugins (git, hg, svn, etc)
* Tab completion
* Syntax extensions for JavaScript libraries
* Better indentation for JavaScript code
* No code folding of any kind

Usage
============

The following commands will clone the repo, symlink `~/.vimrc` and update the
bundles::

    git clone https://github.com/Tudmotu/dotvim.git ~/.vim
    ln -s ~/.vim/vimrc ~/.vimrc
    cd ~/.vim

To add or override settings, place them in ``~/.vim/vimrc.local``.

To install plugins using Vundle, from within vim::

    :VundleInstall


Shortcuts and re-Mappings
============================

======================  =================================================================
Key                     Command
======================  =================================================================
``jj``                  ``<Esc>`` in insert and command modes
----------------------  -----------------------------------------------------------------
``,``                   ``<Leader>``
----------------------  -----------------------------------------------------------------
``<Leader>v``           Load `.vimrc`
----------------------  -----------------------------------------------------------------
``<Leader>V``           Activate changes to `.vimrc` (Make sure to save it before)
----------------------  -----------------------------------------------------------------
``<F2>``                Close current split (window)
----------------------  -----------------------------------------------------------------
``<F3>``                Toggle NERD tree
----------------------  -----------------------------------------------------------------
``<F4>``                Toggle search highlight
----------------------  -----------------------------------------------------------------
``<F5>``                Toggle Tagbar
----------------------  -----------------------------------------------------------------
``<Leader>S``           Remove trailing whitespace
----------------------  -----------------------------------------------------------------
``<CTRL>hjkl``          Window movement commands (mapped via MiniBufExplorer settings)
----------------------  -----------------------------------------------------------------
``<CTRL>arrow``         Window movement commands (mapped via MiniBufExplorer settings)
----------------------  -----------------------------------------------------------------
``<CTRL-TAB>``          Next buffer in current window (via MiniBufExplorer settings)
----------------------  -----------------------------------------------------------------
``<CTRL-SHIFT-TAB>``    Previous buffer in current window (via MiniBufExplorer settings)
----------------------  -----------------------------------------------------------------
``-``, ``+``            Resize horizontal splits
----------------------  -----------------------------------------------------------------
``<ALT><`` ``<ALT>>``   Resize vertical splits
----------------------  -----------------------------------------------------------------
``<F9>``                Toggle logical (RTL, e.g: Hebrew) editing
----------------------  -----------------------------------------------------------------
``<F8>``                Toggle visual (RTL, e.g: Hebrew) editing
----------------------  -----------------------------------------------------------------
``g/``                  :Ack<Space>
----------------------  -----------------------------------------------------------------
``g*``                  :Ack -w current_word
----------------------  -----------------------------------------------------------------
``ga``                  :AckAdd! (add results to the current search)
----------------------  -----------------------------------------------------------------
``<TAB>``               Indent line in visual and normal modes
----------------------  -----------------------------------------------------------------
``<S-TAB>``             Unindent line in visual and normal modes
----------------------  -----------------------------------------------------------------
``<HOME>``              'Soft-Home' (first non-white-space character)
----------------------  -----------------------------------------------------------------
``<Leader>T=``          Align the ``=`` signs in a block of variables
----------------------  -----------------------------------------------------------------
``<Leader>T=``          Align the ``:`` signs in a block of variables
----------------------  -----------------------------------------------------------------
``<Leader>jgs``         :InsertBothGetterSetter
----------------------  -----------------------------------------------------------------
``<Leader>js``          :InsertSetterOnly
----------------------  -----------------------------------------------------------------
``<Leader>jg``          :InsertGetterOnly
======================  =================================================================

if &compatible
    set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.vim/dein')
    call dein#begin('~/.vim/dein')

    " Let dein manage dein
    " Required:
    call dein#add('~/.vim/dein/repos/github.com/Shougo/dein.vim')

    call dein#add('justinmk/vim-syntax-extra')

    " Stuff stolen from github.com/monokrome
    call dein#add('Shougo/denite.nvim')
    call dein#add('duff/vim-bufonly') " Remove all other buffers except the current with :BufOnly
    call dein#add('majutsushi/tagbar', {'on_cmd': 'TagbarToggle'}) " A tagbar pane for the current buffer
    call dein#add('neochrome/todo.vim') " A todo list for Vim.
    call dein#add('tpope/vim-commentary') " Comment and uncomment lines with 'gc' verbs
    call dein#add('tpope/vim-sensible') " Somewhat sensible defaults for modernizing Vim a bit by default.
    " call dein#add('tpope/vim-speeddating') " Manages dates more easily by adding support for them to CTRL-A/CTRL-X
    call dein#add('vim-scripts/TaskList.vim') " Provides lists of tasks (TODO, FIXME, etc) related to the current buffer
    " call dein#add('taxilian/a.vim') " Commands for jumping between alternate related files

    call dein#add('tpope/vim-surround')
    call dein#add('tpope/vim-fugitive')
    call dein#add('tpope/vim-dispatch')
    call dein#add('scrooloose/syntastic')
    call dein#add('scrooloose/nerdtree', {'on_cmd': 'NERDTree'})

    call dein#add('skywind3000/asyncrun.vim')

    " call dein#add('chrisjohnson/vim-foldfunctions')

    call dein#add('SirVer/ultisnips')
    call dein#add('honza/vim-snippets', {'depends': ['ultisnips']})

    call dein#add('jiangmiao/auto-pairs')

    call dein#add('scrooloose/nerdcommenter')

    call dein#add('bling/vim-airline')
    call dein#add('godlygeek/tabular', {'on_cmd': 'Tabularize'})

    call dein#add('Valloric/YouCompleteMe', { 'on_ft': ['c', 'cpp', 'go', 'rust'], 'build': 'python2 ./install.py --clang-completer --gocode-completer --racer-completer --tern-completer'})

    call dein#add('kien/ctrlp.vim', {'on_cmd': ['CtrlP', 'CtrlPMRUFiles', 'CtrlPCurrWD']})
    call dein#add('mileszs/ack.vim', {'on_cmd': 'Ack'})
    call dein#add('airblade/vim-gitgutter')
    " call dein#add('junegunn/goyo.vim', {'on_cmd': 'Goyo'})

    call dein#add('lyuts/vim-rtags')

    call dein#add('fatih/vim-go', {'on_ft': ['go']})

    call dein#add('rust-lang/rust.vim', {'on_ft': ['rust']})

    " These plugins have no plugin/ directory, no need to be lazy
    " call dein#add('suan/vim-instant-markdown')
    " call dein#add('tpope/vim-markdown')
    " call dein#add('suan/vim-instant-markdown', {'on_ft': ['markdown']})
    " call dein#add('tpope/vim-markdown', {'on_ft': ['markdown']})

    call dein#add('dawikur/algorithm-mnemonics.vim', { 'on_ft': ['cpp'] })

    " Colorschemes
    call dein#add('chriskempson/base16-vim')

    " Required:
    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
syntax enable

" Here's a few more plugins from github.com/monokrome
"
" call dein#add('sjl/gundo.vim') " Tools to help better manage the undo tree
" call dein#add('guns/vim-sexp') " More nice text objects, operators, and motions!
" call dein#add('mhinz/vim-signify') " Signs that describe your current SCM changeset
" call dein#add('kana/vim-exjumplist') " Plug mappings to jump between buffers in the jumplist
" call dein#add('tommcdo/vim-exchange') " Use cx to exchange text over motions
" Plug 'tpope/vim-unimpaired' " Nice keybinds for toggling, enabling, navigating, etc. using [, ], and c.
" Plug 'terryma/vim-multiple-cursors' " The ability to use multiple cursors
"
" call dein#add('tpope/vim-abolish') " For performing replaces, fixing typos, and otherwise managing many variants of phrases
" call dein#add('tpope/vim-characterize') " Enhances 'ga' to provide more useful information
" Plug 'ervandew/supertab' " Use tab for completions (This breaks stuff?)
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'nathanaelkane/vim-indent-guides' " Guide lines for indentation
" Plug 'nicholaides/words-to-avoid.vim' " Highlights words that should be avoided in technical writing
" Plug 'sbdchd/neoformat' " Clean code for me, plz!
" Plug 'tpope/vim-endwise' " Automatically insert redundant block-closing code
" Plug 'tpope/vim-flatfoot' " Smarter mappings for the {f,F,t,T} motions using CTRL.
" Plug 'tpope/vim-jdaddy' " JSON text objects
" Plug 'tpope/vim-obsession' " Automatic session management via :Obsession
" Plug 'tpope/vim-projectionist' " Scaffolding in Vim
" Plug 'tpope/vim-repeat' " Makes repeat even more powerful
" Plug 'vim-scripts/openssl.vim' " Allows wrapping Vim's I/O around OpenSSL
" Plug 'wellle/targets.vim' " Some smart generic text objects!

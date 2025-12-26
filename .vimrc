" --- General Visual Settings ---
syntax on               " Enable syntax highlighting
set number              " Show line numbers
set ruler               " Show cursor position in the status line
set laststatus=2        " Always show the status line

" --- Indentation and Formatting ---
set nocompatible        " Behave as Vim, not Vi (essential for modern features)
set autoindent          " Copy indent from the previous line
set smartindent         " Intelligent auto-indenting for new lines
set tabstop=2           " A tab character occupies 4 spaces
set shiftwidth=2        " Indentation steps for auto-indent/shifting
set softtabstop=2       " Number of spaces a <Tab> counts for in insert mode
set expandtab           " Use spaces instead of tabs

" --- Search Options ---
set incsearch           " Show partial matches while typing search
set ignorecase          " Ignore case in search patterns
set smartcase           " Override 'ignorecase' if the search pattern contains uppercase letters
set hlsearch            " Highlight search results
" nnoremap <silent> <C-l> :nohl<CR> " Optional: Clear search highlights with Ctrl+L

" Use the system clipboard (requires vim compiled with +clipboard or +xterm_clipboard)
" set clipboard=unnamedplus


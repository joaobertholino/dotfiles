" --- General Visual Settings ---
syntax on               " Enable syntax highlighting
set number              " Show line numbers
set ruler               " Show cursor position in the status line
set laststatus=2        " Always show the status line
set termguicolors       " Enable colors support

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
set clipboard=unnamedplus


" --- LaTeX (VimTeX) ---
let s:tex_bin = expand('~/.local/share/texlive/2026/bin/x86_64-linux')
if isdirectory(s:tex_bin) && stridx(':' . $PATH . ':', ':' . s:tex_bin . ':') < 0
  let $PATH = s:tex_bin . ':' . $PATH
endif
unlet s:tex_bin

let g:tex_flavor = 'latex'
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_compiler_latexmk = {'continuous': 1, 'callback': 1}
let g:vimtex_compiler_latexmk_engines = {'_': '-lualatex'}
let g:vimtex_view_method = 'zathura_simple'
let g:vimtex_view_automatic = 0
" The installed Zathura lacks SyncTeX; PDF viewing still works normally.
let g:vimtex_view_zathura_use_synctex = 0
let g:vimtex_quickfix_open_on_warning = 0

filetype plugin indent on

augroup personal_latex
  autocmd!
  autocmd FileType tex setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType tex nnoremap <buffer> <silent> <F5> <Cmd>VimtexCompile<CR>
  autocmd FileType tex nnoremap <buffer> <silent> <F6> <Cmd>VimtexView<CR>
  autocmd FileType tex nnoremap <buffer> <silent> <F7> <Cmd>VimtexErrors<CR>
augroup END

" Compile saved LaTeX projects automatically, without toggling a running job.
function! s:LatexStartCompiler() abort
  if exists('b:vimtex') && b:vimtex.compiler.enabled
        \ && filereadable(b:vimtex.tex) && b:vimtex.is_compileable()
        \ && !b:vimtex.compiler.is_running()
    call vimtex#compiler#start()
  endif
endfunction

" Autosave only named, writable LaTeX buffers, after one second of inactivity.
function! s:LatexAutosave(buffer, timer) abort
  if bufnr('%') != a:buffer || &l:filetype !=# 'tex'
        \ || &l:buftype !=# '' || !&l:modified || !&l:modifiable
        \ || &l:readonly || empty(expand('%:p'))
    return
  endif
  try
    silent update
  catch
    echohl WarningMsg
    echom 'LaTeX autosave failed: ' . v:exception
    echohl None
  endtry
endfunction

function! s:LatexScheduleAutosave() abort
  if &l:filetype !=# 'tex'
    return
  endif
  call timer_stop(get(b:, 'latex_autosave_timer', -1))
  let b:latex_autosave_timer = timer_start(1000,
        \ function('<SID>LatexAutosave', [bufnr('%')]))
endfunction

function! s:LatexFlushAutosave() abort
  if &l:filetype ==# 'tex'
    call timer_stop(get(b:, 'latex_autosave_timer', -1))
    call s:LatexAutosave(bufnr('%'), -1)
  endif
endfunction

augroup personal_latex_automation
  autocmd!
  autocmd User VimtexEventInitPost call <SID>LatexStartCompiler()
  autocmd BufWritePost *.tex,*.ltx call <SID>LatexStartCompiler()
  autocmd TextChanged,TextChangedI * call <SID>LatexScheduleAutosave()
  autocmd BufLeave,FocusLost,VimLeavePre * call <SID>LatexFlushAutosave()
augroup END

" --- Automatic LaTeX completion and GitHub Copilot ---
set completeopt=menuone,noselect,noinsert
set shortmess+=c
let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#no_mappings = 1
let g:mucomplete#completion_delay = 150
let g:mucomplete#chains = {'default': [], 'tex': ['omni', 'keyn']}

let g:copilot_node_command = '/usr/bin/node'
let g:copilot_command = [expand('~/.local/share/vim-copilot/node_modules/@github/copilot-language-server/dist/language-server.js')]
let g:copilot_no_tab_map = 1
let g:copilot_filetypes = {'*': v:false, 'tex': v:true}

function! s:LatexAcceptSuggestion() abort
  if pumvisible()
    return complete_info(['selected']).selected < 0
          \ ? "\<C-n>\<C-y>" : "\<C-y>"
  endif
  return copilot#Accept("\<Tab>")
endfunction

augroup personal_latex_completion
  autocmd!
  autocmd FileType tex inoremap <buffer> <silent> <script> <expr> <Tab> <SID>LatexAcceptSuggestion()
  autocmd FileType tex inoremap <buffer> <silent> <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-d>"
  autocmd FileType tex imap <buffer> <C-Space> <Plug>(MUcompleteFwd)
  autocmd FileType tex imap <buffer> <C-@> <Plug>(MUcompleteFwd)
  autocmd FileType tex imap <buffer> <C-Tab> <Plug>(copilot-accept-word)
  autocmd FileType tex imap <buffer> <C-l> <Plug>(copilot-accept-word)
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Info                                                                     @info
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" # About
"
" Author: Daniil Velichko <danvelduck@gmail.com>
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins                                                               @plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" # Init
"
call plug#begin('~/.local/share/nvim/plugged')
"
" # System
"
Plug 'prabirshrestha/async.vim'
"
" # Editing
"
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
"
" # Integration
"
Plug 'airblade/vim-gitgutter'
Plug 'lambdalisue/gina.vim'
"
" # Appearance
"
Plug 'drewtempelmeyer/palenight.vim'
Plug 'itchyny/lightline.vim'
"
" # Navigation
"
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'uptech/alt'
Plug 'dyng/ctrlsf.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'kien/tabman.vim'
"
" # Utility
"
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'
Plug 'sjl/gundo.vim'
"
" # Languages
"
Plug 'prabirshrestha/vim-lsp'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'rust-lang/rust.vim'
Plug 'calviken/vim-gdscript3'
"
call plug#end()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim configuration                                                   @vimconfig
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" # General
"
set nocompatible
let mapleader=","
set backupdir=~/.vim/backup//
set directory=~/.vim/swp//
"
" # Editing
"
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set nocindent
set nosmartindent

"
" UI
"
set t_Co=256
set termguicolors
set background=dark
colorscheme palenight
let g:palenight_terminal_italics=1
hi link SpecialComment Comment
set signcolumn=yes
set showtabline=0
set wildmenu
set mouse=a
set noshowmode
set number
set hidden
set noshowmatch
set fillchars=
set splitbelow
set splitright
set wmh=0
set textwidth=100
set nowrap
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins configuration                                            @pluginconfig
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Defx
"
autocmd FileType defx call s:defx_my_settings()
	function! s:defx_my_settings() abort
	  nnoremap <silent><buffer><expr> <cr>
	  \ defx#do_action('open')
	  nnoremap <silent><buffer><expr> c
	  \ defx#do_action('copy')
	  nnoremap <silent><buffer><expr> m
	  \ defx#do_action('move')
	  nnoremap <silent><buffer><expr> p
	  \ defx#do_action('paste')
	  nnoremap <silent><buffer><expr> l
	  \ defx#do_action('open')
	  nnoremap <silent><buffer><expr> E
	  \ defx#do_action('open', 'vsplit')
	  nnoremap <silent><buffer><expr> P
	  \ defx#do_action('open', 'pedit')
	  nnoremap <silent><buffer><expr> K
	  \ defx#do_action('new_directory')
	  nnoremap <silent><buffer><expr> N
	  \ defx#do_action('new_file')
	  nnoremap <silent><buffer><expr> d
	  \ defx#do_action('remove')
	  nnoremap <silent><buffer><expr> r
	  \ defx#do_action('rename')
	  nnoremap <silent><buffer><expr> x
	  \ defx#do_action('execute_system')
	  nnoremap <silent><buffer><expr> yy
	  \ defx#do_action('yank_path')
	  nnoremap <silent><buffer><expr> .
	  \ defx#do_action('toggle_ignored_files')
	  nnoremap <silent><buffer><expr> h
	  \ defx#do_action('cd', ['..'])
	  nnoremap <silent><buffer><expr> ~
	  \ defx#do_action('cd')
	  nnoremap <silent><buffer><expr> q
	  \ defx#do_action('quit')
	  nnoremap <silent><buffer><expr> <Space>
	  \ defx#do_action('toggle_select') . 'j'
	  nnoremap <silent><buffer><expr> *
	  \ defx#do_action('toggle_select_all')
	  nnoremap <silent><buffer><expr> j
	  \ line('.') == line('$') ? 'gg' : 'j'
	  nnoremap <silent><buffer><expr> k
	  \ line('.') == 1 ? 'G' : 'k'
	  nnoremap <silent><buffer><expr> <C-r>
	  \ defx#do_action('redraw')
	  nnoremap <silent><buffer><expr> <C-g>
	  \ defx#do_action('print')
endfunction
"
" FZF
"
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Use ripgrep
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview(),
  \   <bang>0)

" Use file previews
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" Default fzf layout
let g:fzf_layout = { 'window': '20split enew' }

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
"
" AsyncComplete
"
let g:asyncomplete_remove_duplicates = 1
let g:asyncomplete_smart_completion = 1
let g:asyncomplete_auto_popup = 1
set completeopt+=preview
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'whitelist': ['*'],
    \ 'blacklist': ['rust', 'javascript', 'typescript'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ }))
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'whitelist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))
"
" Tabman
"
let g:tabman_width = 40
let g:tabman_side = 'right'
let g:tabman_number = 0
"
" Language Server
"
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_signs_enabled = 1
let g:lsp_signs_error = {'text': '!'}
let g:lsp_signs_warning = {'text': '?'}
let g:lsp_signs_information = {'text': '*'}
let g:lsp_signs_hint = {'text': '#'}
hi link LspErrorText SignColumn
hi link LspWarningText SignColumn
hi link LspInformationText SignColumn
hi link LspHintText SignColumn
if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
endif
if executable('typescript-language-server')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
        \ 'whitelist': ['typescript'],
        \ })
endif
"
" surround
"
let g:surround_indent = 0
"
" lightline
"
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'relativepath', 'modified' ] ]
      \ }
      \ }
let g:lightline.colorscheme = 'palenight'
"
" gitgutter
"
let g:gitgutter_map_keys = 0
"
" alt
"
function! AltCommand(path, vim_command)
	let l:alternate = system("find . -path ./_site -prune -or -path ./target -prune -or -path ./.DS_Store -prune -or -path ./build -prune -or -path ./Carthage -prune -or -path tags -prune -or -path ./tmp -prune -or -path ./log -prune -or -path ./.git -prune -or -path ./dist -prune -or -path ./node_modules -prune -or -type f -print | alt -f - " . a:path)
	if empty(l:alternate)
		echo "No alternate file for " . a:path . " exists!"
	else
		exec a:vim_command . " " . l:alternate
	endif
endfunction
"
" Vim-Markdown
"
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_no_default_key_mappings = 1
"
" Rust.vim
"
let g:rustfmt_autosave = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom code                                                            @custom
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keymap                                                                 @keymap
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" All custom commands are categorized under leader.
" <leader>[<category>]<map>
"
" Some common commands have alternate mapping with <space>-<map>
"
" ## Meta
" 
" open vim config
nnoremap <leader>mc :e $MYVIMRC<cr>

" reload vim config
nnoremap <leader>mr :so $MYVIMRC<cr>

" disable search highlighting
nnoremap <leader>/ :nohlsearch<cr>

"
" ## File
"
" show file tree
nnoremap <leader>ft :Defx -toggle -split=vertical -winwidth=40 -direction=topleft<cr>
nnoremap <space>t :Defx -toggle -split=vertical -winwidth=40 -direction=topleft<cr>

" go to file in project
nnoremap <leader>fp :Files<cr>
nnoremap <space>p :Files<cr>

" search in files under CWD
nnoremap <leader>fs :CtrlSF<space>
nnoremap <space>/ :CtrlSF<space>

" search current word in files under CWD
nnoremap <leader>fS :CtrlSF<cr>

" go to alternate file
nnoremap <leader>fa :w<cr>:call AltCommand(expand('%'), ':e')<cr>
nnoremap <space>. :w<cr>:call AltCommand(expand('%'), ':e')<cr>

"
" ## Tab
"
" toggle tab *drawer*
nnoremap <leader>mt :TMToggle<cr>
nnoremap <space>d :TMToggle<cr>

"
" ## Window
"
" move one line down
nnoremap j gj

" move one line up
nnoremap k gk

" move to next window below
nnoremap <C-j> <C-w>j

" move to next window above
nnoremap <C-k> <C-w>k

" move to next window to the left
nnoremap <C-h> <C-w>h

" move to next window to the right
nnoremap <C-l> <C-w>l

"
" ## Buffer
"
" search for opened *buffer*
nnoremap <leader>bb :Buffers<cr>
nnoremap <space>b :Buffers<cr>

" search for *lines* in current buffer
nnoremap <leader>bl :BLines<cr>
nnoremap <space>l :BLines<cr>

" search for *lines* in all opened buffers
nnoremap <leader>bL :Lines<cr>
nnoremap <space>L :Lines<cr>

" *save* buffer
nnoremap <leader>bs :w<cr>
nnoremap <space>s :w<cr>

" open undo *history*
nnoremap <leader>bh :GundoToggle<cr>
nnoremap <space>h :GundoToggle<cr>

"
" ## Text
" 
" align text
nmap <leader>ta <Plug>(EasyAlign)
xmap <space>a <Plug>(EasyAlign)

"
" ## Code
"
" go to *definition*
nnoremap <silent> <leader>cd :LspDefinition<cr>

" show *usages*
nnoremap <silent> <leader>cu :LspReferences<cr>

" show *info* about symbol under cursor
nnoremap <silent> <leader>ci :LspHover<cr>

" *list* document symbols
nnoremap <silent> <leader>cl :LspDocumentSymbol<cr>

" *search* workspace symbols
nnoremap <silent> <leader>cs :LspWorkspaceSymbol<cr>

" *rename* symbol under cursor
nnoremap <silent> <leader>cr :LspRename<cr>

" show known *errors*
nnoremap <silent> <leader>ce :LspDocumentDiagnostics<cr>

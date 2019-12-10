"
" I use some external libraries.
" On macOS, you should run `brew install fzf bat ripgrep` before using
" this vimrc.
"
filetype plugin on

" Plug settings.
call plug#begin('~/.vim/plugged')
  " Themes
  Plug 'kooparse/vim-color-desert-night'
  " Simple status bar
  Plug 'itchyny/lightline.vim'
  " File directory manager
  Plug 'scrooloose/nerdtree'
  " Vim defaults
  Plug 'tpope/vim-sensible'
  " Showing marks
  Plug 'kshenoy/vim-signature'
  " Searh & replace through quickfix
  Plug 'wincent/ferret'
  " Make the yanked region apparent
  Plug 'machakann/vim-highlightedyank'
  " Helpers UNIX
  Plug 'tpope/vim-eunuch'
  " Enable repeating supported plugins maps
  Plug 'tpope/vim-repeat'
  " Quoting made simple
  Plug 'tpope/vim-surround'
  " Comment stuff out
  Plug 'tpope/vim-commentary'
  " Language pack
  Plug 'sheerun/vim-polyglot'
  " Typecript highlightss (polyglot is fucked)
  Plug 'HerringtonDarkholme/yats.vim'
  " Linter
  Plug 'w0rp/ale'
  " Git stuff inside vim
  Plug 'tpope/vim-fugitive'
  " A git commit browser
  Plug 'junegunn/gv.vim'
  " Zen mode
  Plug 'junegunn/goyo.vim'
  " Fuzzy finder
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  " Auto-completer + LSP
  Plug 'prabirshrestha/asyncomplete.vim'
  " C# and Unity
  Plug 'OmniSharp/omnisharp-vim'
  " Ulti Snipet (Omnisharp dependencies)
  Plug 'SirVer/ultisnips'
  " EasyMotion
  Plug 'Lokaltog/vim-easymotion'

call plug#end()

let g:polyglot_disabled = ['typescript']

" Setup syntax highlights
set termguicolors
set background=dark
" Contrast + Colorscheme
colo desert-night
 
" Colorize lightline + add relative path
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'relativepath', 'modified' ] ]
      \ }
      \ }

" Everybody do that
set nocompatible
" Scrolling offset
set scrolloff=3
" Turn on auto indent
set autoindent
" Disable swap files
set noswapfile
" No backup file while editing
set nowritebackup
" Auto save the file when closing
set autowrite
" Hide buffer when unsaved
set hidden
" Highlight current line
set cursorline
" Hide lines number
set number
" Show existing tabs with 2 spaces
set tabstop=4
" When indenting with '>', use 2 spaces width
set shiftwidth=4
" Mode in status bar
set noshowmode
" Browse files in same dir as open file
set browsedir=buffer
" Better split characters
set fillchars=vert:\ ,stl:\ ,stlnc:\
" Highlight search matches
set hlsearch
set incsearch
set ignorecase
set smartcase
" Global flag for search by default
set gdefault
" Format completeopt list
set completeopt=noinsert,menuone,noselect
set previewheight=10
" Always draw the signcolumn
set signcolumn=yes
" Open new vertical split to the right by default
set splitright
set splitbelow
set switchbuf="useopen, vsplit"
" Bind vim grep to ripgrep
set grepprg=rg\ --no-heading\ --vimgrep
set grepformat=%f:%l:%c:%m
" Search
set wildmenu
set wildmode=list:full
set wildignore+=*/node_modules/*
" Undodir
set undodir=~/.config/vim/tmp/undo//
set undofile

" Leader key
let mapleader = "\<Space>"
" Escape key
inoremap kj <esc>
" NerdTree
map <C-n> :NERDTreeToggle<CR>

let g:ale_linters = {
      \ 'cs': ['OmniSharp'],
      \ 'javascript': ['flow', 'eslint'],
      \ 'typescript': ['tsserver'],
      \ 'rust': ['rls'],
      \ 'go': ['gometalinter']
      \ }

let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'cs': ['uncrustify'],
      \ 'rust': ['rustfmt'],
      \ 'html': ['prettier'],
      \ 'javascript': ['prettier'],
      \ 'typescript': ['prettier'],
      \ 'css': ['prettier'],
      \ 'markdown': ['prettier'],
      \ 'go': ['gofmt']
      \ }

" Javascript Ale rules
let g:jsx_ext_required = 0
" Ale bindings
nmap <leader>q <Plug>(ale_fix)
nmap <silent> gd :ALEGoToDefinition<CR>
" Binding for moving through errors
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" FZF configuration (with Rg)
let $FZF_PREVIEW_COMMAND = 'bat --style=numbers --color=always --theme="1337" {}'
let $FZF_DEFAULT_COMMAND= 'rg --files --hidden -g "!{.git/*}"'
let g:fzf_layout = { 'down': '~20%' }
let g:fzf_buffers_jump = 1
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --fixed-strings --color=always '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:40%'),
  \   <bang>0)

" Bind Fuzzy search cmd
nmap <Leader>b :Buffers<CR>
nmap <Leader>f :Files<CR>
nmap <Leader>s :Rg<Space>

" Jump to quickfix
let g:FerretAutojump=1
" Mapping to populate the quickfix
nmap <leader>g <Plug>(FerretAck)
" Mapping to replace the quickfix
nmap <leader>r <Plug>(FerretAcks)

" Copy & paste to system clipboard
nmap <leader>p "+p
vmap <leader>y "+y
" open vimrc file
nmap <leader>ev :e ~/.vimrc<CR>
" Toggles between buffers
nmap <leader><leader> <c-^>
" Focus next pane
nmap <leader>w <C-w><C-w>
" Search current buffer siblings
nmap <leader>n :e %:h/
" Search current buffer siblings and throw it in a right pane
nmap <leader>N :vsp \| drop %:h/
" Replace the word under the cursor
nmap <leader>x *``cgn
" Vertical focus split
nmap <leader>v <C-w>v<C-w>l
" Compile and check programs (Rust)
nmap <leader>c :!cargo check<CR>
" Compile and run programs (Rust)
nmap <leader>C :!cargo run<CR>
" Better split navigation
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
" nmap <C-L> <C-W><C-L>
nmap <C-H> <C-W><C-H>
" Swap current line
nmap ]e :m+<CR>
nmap [e :m-2<CR>
" Add newlines before and after the cursor line
nmap [<space> O<Esc>j
nmap ]<space> o<Esc>k
" Open folder for current project.
nmap <leader>o :!open .<CR>
" Break line on cursor position
nmap <C-cr> i<CR><Esc>
" Search results centered please
nmap <silent> n nzz
nmap <silent> N Nzz
nmap <silent> * *zz
nmap <silent> # #zz
nmap <silent> g* g*zz

"Splitting  panes
"vv to generate new vertical split
nnoremap <silent> vv <C-w>v

"Moving inside split panes
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Moving between opened files, buffers
set hidden "allows to switch of buffer without saving the current buffer
map <Leader><Tab> :bn<cr>
map <Leader><S-Tab> :bp<cr>

" Completion shortcut
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Powerline" 
set rtp+=/usr/local/lib/python3.6/site-packages/powerline/bindings/vim
set laststatus=2
set t_Co=256

" Omnisharp settings
" Note: this is required for the plugin to work
filetype indent plugin on

" Use the stdio OmniSharp-roslyn server
let g:OmniSharp_server_stdio = 1

" Set the type lookup function to use the preview window instead of echoing it
"let g:OmniSharp_typeLookupInPreview = 1

" Timeout in seconds to wait for a response from the server
let g:OmniSharp_timeout = 5

" Don't autoselect first omnicomplete option, show options even if there is only
" one (so the preview documentation is accessible). Remove 'preview' if you
" don't want to see any documentation whatsoever.
"set completeopt=longest,menuone,preview

" Fetch full documentation during omnicomplete requests.
" By default, only Type/Method signatures are fetched. Full documentation can
" still be fetched when you need it with the :OmniSharpDocumentation command.
"let g:omnicomplete_fetch_full_documentation = 1

" Set desired preview window height for viewing documentation.
" You might also want to look at the echodoc plugin.
set previewheight=5

" Tell ALE to use OmniSharp for linting C# files, and no other linters.
let g:ale_linters = { 'cs': ['OmniSharp'] }

" Update semantic highlighting after all text changes
let g:OmniSharp_highlight_types = 3
" Update semantic highlighting on BufEnter and InsertLeave
" let g:OmniSharp_highlight_types = 2

augroup omnisharp_commands
    autocmd!

    " Show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    " The following commands are contextual, based on the cursor position.
    autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>

    " Finds members in the current buffer
    autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>

    autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>
    autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
    autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>

    " Navigate up and down by method/property/field
    autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
    autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>

    " Find all code errors/warnings for the current solution and populate the quickfix window
    autocmd FileType cs nnoremap <buffer> <Leader>cc :OmniSharpGlobalCodeCheck<CR>
augroup END

" Rename with dialog
nnoremap <Leader>nm :OmniSharpRename<CR>
nnoremap <F2> :OmniSharpRename<CR>
" Rename without dialog - with cursor on the symbol to rename: `:Rename newname`
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

nnoremap <Leader>cf :OmniSharpCodeFormat<CR>

" Start the omnisharp server for the current solution
nnoremap <Leader>ss :OmniSharpStartServer<CR>
nnoremap <Leader>sp :OmniSharpStopServer<CR>

" Enable snippet completion
let g:OmniSharp_want_snippet=1

" Auto source/reload vimrc on save
augroup myvimrchooks
  au!
  autocmd bufwritepost .vimrc source ~/.vimrc
augroup END

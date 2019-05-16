"Vundle pulgin to install other plugin
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'christoomey/vim-tmux-navigator'

"Git 
Plugin 'tpope/vim-fugitive'

Plugin 'scrooloose/nerdtree'
noremap <C-n> :NERDTreeToggle<cr>

"Fuzzy file finder
Plugin 'ctrlpvim/ctrlp.vim'
let g:ctrlp_show_hidden = 1

"Syntax
Plugin 'vim-syntastic/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
     
Plugin 'vim-airline/vim-airline'

Plugin 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 2

Plugin 'edkolev/tmuxline.vim'
let g:tmuxline_powerline_separators = 0

"Autocompletion
Plugin 'Valloric/YouCompleteMe'
"" turn on completion in comments
let g:ycm_complete_in_comments=1
"" load ycm conf by default
let g:ycm_confirm_extra_conf=0
"" turn on tag completion
let g:ycm_collect_identifiers_from_tags_files=1
"" only show completion as a list instead of a sub-window
set completeopt-=preview
"" start completion from the first character
let g:ycm_min_num_of_chars_for_completion=1
"" don't cache completion items
let g:ycm_cache_omnifunc=0
"" complete syntax keywords
let g:ycm_seed_identifiers_with_syntax=1
"" make sure that autocompletion window goes away
let g:ycm_autoclose_preview_window_after_completion=1
"" goto definition shortcut
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>


"Color
Plugin 'chase/focuspoint-vim'
"Javascript colors
Plugin 'crusoexia/vim-monokai'

"Python plugins
Plugin 'vim-scripts/indentpython.vim'
Plugin 'nvie/vim-flake8'



"""""""""""""""""""""""""""""""""""

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"""""Mapping 

"Escape
inoremap kj <esc>

"Leader as Space
let mapleader = "\<Space>"
nnoremap <Leader>a :echo "GG there space"<CR>

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

"Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR><silent> vv <C-w>v
" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>

"""""Other
set encoding=utf-8
"Enable system clipboard allowing to copy paste from system
set clipboard=unnamed
"Line number
set relativenumber
"Tabulation printing
set list
set lcs=tab:\|\  " the last character is space!
"Bell song
set vb t_vb=     " no visual bell & flash
"Color
syntax on
colorscheme monokai

"Python configuration
"Execute python current file
nnoremap <buffer> <F5> :exec '!python' shellescape(@%, 1)<cr>

"Indentation
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

"Flagging unnecessary whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

"Highlighting
let python_highlight_all=1

"Virtualenv support
"python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
	project_base_dir = os.environ['VIRTUAL_ENV']
	activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
	execfile(activate_this, dict(__file__=activate_this))
EOF

set nocompatible              " be iMproved, required
filetype off                  " required
let g:powerline_pycmd = "py3"

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'tpope/vim-git'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-endwise'

Plugin 'vim-scripts/L9'
" To be able to view nested zip recursively
Plugin 'ervandew/archive'
Plugin 'othree/vim-autocomplpop'
Plugin 'Firef0x/vim-smali'
Plugin 'chrisbra/vim-diff-enhanced'
Plugin 'will133/vim-dirdiff'

" Syntax checking plugin
Plugin 'scrooloose/syntastic'

" Tabulation with :Tab /<=,:,|>
Plugin 'godlygeek/tabular'
Plugin 'vim-scripts/matchit.zip'
Plugin 'vim-scripts/closetag.vim'

" Livre preview of sed commands
Plugin 'xtal8/traces.vim'

Plugin 'actionshrimp/vim-xpath'
Plugin 'kovetskiy/sxhkd-vim'
Plugin 'chriskempson/base16-vim'
Plugin 'rodjek/vim-puppet'

call vundle#end()
filetype plugin indent on    " required

syntax on
filetype indent on
set autoindent
set nu
set hls
set is
set ic
set expandtab
set shiftwidth=4
set softtabstop=4

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

set background=dark
let base16colorspace=256
set cursorline

" Other
set pastetoggle=<F10>

let Tlist_Compact_Format = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
nnoremap <C-l> :TlistToggle<CR>

set laststatus=2
set noshowmode

" Only enable mouse in normal mode as I generally don't want to change the
" focus with the mouse in other modes
set mouse=n

set history=1000
"TAB completion complete longest common string then list possibility
set wildmode=longest,list
"Automatically hide buffer when switching to another buffer
set hidden

"Fast leave when pressing ESC
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

set showcmd " Shows the command in the last line of the screen.

set smartcase

set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
"let g:Tex_CompileRule_pdf = 'lualatex -shell-escape -interaction=nonstopmode $*'
"let g:Tex_CompileRule_dvi = 'lualatex -shell-escape -interaction=nonstopmode -output-format dvi $*'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats = 'dvi,pdf'
imap <Alt-B> <Plug>Tex_MathBF
" Fix issue with <S-F5> macro
let b:DoubleDollars = 0

autocmd BufEnter *.txt set spell spelllang=fr
autocmd BufEnter *.tex set spell spelllang=fr

let g:languagetool_disable_rules = 'FRENCH_WHITESPACE,HUNSPELL_NO_SUGGEST_RULE,UNPAIRED_BRACKETS,WHITESPACE_RULE'

command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

"To be able to display line even if it can't be entirely displayed
set display=lastline
set linebreak

"Syntax highlight for md
au BufRead,BufNewFile *.md set filetype=markdown
" gradle syntax highlighting
au BufNewFile,BufRead *.gradle set filetype=groovy

" Syntastic plugin configuration
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

au BufReadCmd *.docx call zip#Browse(expand("<amatch>"))

" Remove octal number support 007
set nrformats=

" format commands
nmap =j :%!python -m json.tool<CR>
nmap =x :%!xmllint --format -<CR>

colorscheme base16-bright
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif
set term=kitty

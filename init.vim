let mapleader=" "

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'vimwiki/vimwiki'
Plug 'morhetz/gruvbox'
Plug 'voldikss/vim-floaterm'
Plug 'mboughaba/i3config.vim'
Plug 'kovetskiy/sxhkd-vim'
Plug 'chrisbra/Colorizer'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'Gavinok/vim-troff'
Plug 'Raimondi/delimitMate'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
call plug#end()

source ~/.config/nvim/coc.vim
autocmd vimenter * colorscheme gruvbox		" calling gruvbox colorscheme

" Neat basics:
	syntax on
	set clipboard+=unnamedplus
	set encoding=utf-8
	set number relativenumber
	set ignorecase
	set nohls
	set linebreak

	set tabstop=4
	set shiftwidth=4

" Know the difference between space and tab!
	set list listchars=nbsp:¬,tab:»·,trail:·,extends:>
" Spell checking
	map <F8> :setlocal spell! spelllang=en_us<CR>

	nnoremap gl $
	nnoremap gh 0

	set cursorline
	set cursorcolumn
	autocmd InsertEnter * norm zz

" A undo history
	set undofile

" Remove last word remap consistantly
	inoremap <C-H> <C-W>

" NerdTree
	nnoremap <leader>n :NERDTreeToggle<CR>

" Start NERDTree when Vim is started without file arguments.
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif


" Fix visual block
	vmap < <gv
	vmap > >gv
	map j gj
	map k gk

" Got suggested from vim wiki:
	set nocompatible
	filetype plugin on
" Enable autocompletion:
	set wildmode=longest,list,full
" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>c :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %

" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	map <leader>v :VimwikiIndex
" Vimwiki markdown
	let g:vimwiki_list = [{'path': '~/MEGAsync/VimWiki', 'syntax': 'markdown', 'ext': '.md'}]

aug i3config_ft_detection
	au!
	au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
aug end


" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!


"" Few usefull auto commands------------
" Automatically deletes all trailing whitespace and newlines at end of file on save.
"	autocmd BufWritePre * %s/\s\+$//e
"	autocmd BufWritepre * %s/\n\+\%$//e
" When shortcut files are updated, renew bash and ranger configs with new material:
	autocmd BufWritePost files,directories !shortcuts
" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost *Xresources,*Xdefaults !xrdb %


"" vim-airline specific
let g:airline_theme='badwolf'
" let g:airline_powerline_fonts=1

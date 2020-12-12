let mapleader=","

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'vimwiki/vimwiki'
Plug 'morhetz/gruvbox'
Plug 'voldikss/vim-floaterm'
Plug 'mboughaba/i3config.vim'
Plug 'kovetskiy/sxhkd-vim'
Plug 'chrisbra/Colorizer'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
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
	set textwidth=100
	set linebreak

	set tabstop=4
	set shiftwidth=4

	nnoremap gl $
	nnoremap gh 0

	set cursorline
	set cursorcolumn
	autocmd InsertEnter * norm zz

" commenting with hashtag
	vnoremap <silent> # :s/^/# /<cr>:noh<cr>
	vnoremap <silent> -# :s/^# //<cr>:noh<cr>


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
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff autocmd BufRead,BufNewFile *.tex set filetype=tex
" Vimwiki markdown
	let g:vimwiki_list = [{'path': '~/Notes/VimWiki', 'syntax': 'markdown', 'ext': '.md'}]

aug i3config_ft_detection
	au!
	au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
aug end


" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!


"" Few usefull auto commands------------
" Automatically deletes all trailing whitespace and newlines at end of file on save.
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritepre * %s/\n\+\%$//e
" When shortcut files are updated, renew bash and ranger configs with new material:
	autocmd BufWritePost files,directories !shortcuts
" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost *Xresources,*Xdefaults !xrdb %


if exists('g:started_by_firenvim') && g:started_by_firenvim
    " general options
    set laststatus=0 nonumber noruler noshowcmd

    augroup firenvim
        autocmd BufEnter *.txt setlocal filetype=markdown.pandoc
    augroup END
endif

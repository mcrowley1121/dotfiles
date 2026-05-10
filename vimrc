" $VIMRUNTIME refers to the versioned system directory where Vim stores its
" system runtime files -- /usr/share/vim/vim<version>.
"
" Vim will load $VIMRUNTIME/defaults.vim if the user does not have a vimrc.
" This happens after /etc/vim/vimrc(.local) are loaded, so it will override
" any settings in these files.
"
" If you don't want that to happen, uncomment the below line to prevent
" defaults.vim from being loaded.
" let g:skip_defaults_vim = 1
"
" If you would rather _use_ default.vim's settings, but have the system or
" user vimrc override its settings, then uncomment the line below.
" source $VIMRUNTIME/defaults.vim

" All Debian-specific settings are defined in $VIMRUNTIME/debian.vim and
" sourced by the call to :runtime you can find below.  If you wish to change
" any of those settings, you should do it in this file or
" /etc/vim/vimrc.local, since debian.vim will be overwritten everytime an
" upgrade of the vim packages is performed. It is recommended to make changes
" after sourcing debian.vim so your settings take precedence.
if filereadable($VIMRUNTIME . "/debian.vim")
  runtime! debian.vim
endif

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes
" numerous options, so any other options should be set AFTER changing
" 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
filetype plugin indent on

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" =====================================================================
" Custom settings
" =====================================================================

" Default indentation: 2 spaces, expanded
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent

" Make backspace behave like in most other editors
set backspace=indent,eol,start

" Detect .jsonc files as the jsonc filetype (not recognized by default)
autocmd BufRead,BufNewFile *.jsonc setfiletype jsonc

" Highlight trailing whitespace, but not while actively typing on a line
highlight ExtraWhitespace ctermbg=red guibg=red
augroup TrailingWhitespace
  autocmd!
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd BufWinLeave * call clearmatches()
  " Disable trailing-whitespace highlighting in formats where it's syntactic
  autocmd FileType markdown,gitcommit match none
augroup END

" Per-filetype indentation overrides
" YAML and similar formats are sensitive to indentation; keep them at 2 spaces
augroup FiletypeIndentation
  autocmd!
  autocmd FileType yaml,yml      setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd FileType json,jsonc    setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd FileType python        setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
  autocmd FileType go            setlocal tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
  autocmd FileType make          setlocal noexpandtab
augroup END

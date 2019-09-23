set nocompatible

filetype off                  " required

syntax enable on
set nu

set autoindent
set smarttab          "use tabs at the start of a line, spaces elsewhere
set smartindent

set tabstop=4
set softtabstop=4
set shiftwidth=4

set noet
set incsearch
set hlsearch

set ic

set cursorline
set linebreak

set sw=4
set ts=4

set autowriteall

filetype indent on
autocmd FileType python setlocal et sta sw=4 sts=4

set sw=4
set sts=4
set ts=4

let &colorcolumn=100
highlight ColorColumn ctermbg=Yellow

" 下面的颜色(darkgreen)可以自己修改
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
augroup WhitespaceMatch
  autocmd!
  autocmd BufWinEnter * let w:whitespace_match_number =
        \ matchadd('ExtraWhitespace', '\s\+$')
  autocmd InsertEnter * call s:ToggleWhitespaceMatch('i')
  autocmd InsertLeave * call s:ToggleWhitespaceMatch('n')
augroup END
function! s:ToggleWhitespaceMatch(mode)
  let pattern = (a:mode == 'i') ? '\s\+\%#\@<!$' : '\s\+$'
  if exists('w:whitespace_match_number')
    call matchdelete(w:whitespace_match_number)
    call matchadd('ExtraWhitespace', pattern, 10, w:whitespace_match_number)
  else
    let w:whitespace_match_number =  matchadd('ExtraWhitespace', pattern)
  endif
endfunction

autocmd BufWritePre * :%s/\s\+$//e

autocmd bufnewfile *.py so /Users/Neil/.vim_header_py
autocmd bufnewfile *.py exe "1," . 10 . "g/FileName:.*/s//FileName:     " .expand("%")
autocmd bufnewfile *.py exe "1," . 10 . "g/Author:.*/s//Author:       neilhong"
autocmd bufnewfile *.py exe "1," . 10 . "g/@contact:.*/s//@contact:     gzhongzenglin@corp.netease.com"
autocmd bufnewfile *.py exe "1," . 10 . "g/@date:.*/s//@date:        " .strftime("%Y-%m-%d %H:%M:%S")

autocmd bufnewfile *.go so /Users/Neil/.vim_header_go
autocmd bufnewfile *.go exe "2" . "g/FileName:.*/s//FileName:     " .expand("%")
autocmd bufnewfile *.go exe "2," . 9 . "g/Author:.*/s//Author:       neilhong"
autocmd bufnewfile *.go exe "2," . 9 . "g/@contact:.*/s//@contact:     gzhongzenglin@corp.netease.com"
autocmd bufnewfile *.go exe "2," . 9 . "g/@date:.*/s//@date:        " .strftime("%Y-%m-%d %H:%M:%S")

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'hynek/vim-python-pep8-indent'

Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'fatih/vim-go'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" 在 vim 启动的时候默认开启 NERDTree（autocmd 可以缩写为 au）
autocmd VimEnter * NERDTree

" 按下 F2 调出/隐藏 NERDTree
map <F2> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&b:NERDTreeType == "primary") | q | endif

" 当打开 NERDTree 窗口时，自动显示 Bookmarks
let NERDTreeShowBookmarks=1
let NERDTreeIgnore = ['\.pyc$']

let mapleader = ","
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" add yaml stuffs
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab


autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_deadline = "5s"


au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4
set completefunc=emoji#complete

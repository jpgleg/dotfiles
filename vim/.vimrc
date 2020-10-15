set nocompatible
set rtp+=$GOPATH/src/golang.org/x/lint/misc/vim
let g:netrw_dirhistmax=0

syntax on
filetype plugin indent on

" tab and space settings
set autoindent
set ruler
set tabstop=4 softtabstop=0 expandtab shiftwidth=2 smarttab

" Strip trailing whitespaces on save.
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  $put _ | $;?\(^\s*$\)\@!?+1,$d
  call cursor(l, c)
endfun
au BufWritePre * :call <SID>StripTrailingWhitespaces()

let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1
autocmd BufWritePost,FileWritePost *.go execute 'Lint' | cwindow

" highlight matching brackets
:set showmatch

" code folding on matching brackets
:map ff zfa}
:map fo zo

" no backup and swap files
:set nobackup
:set noswapfile

" tab key mappings
:map <S-h> gT
:map <S-l> gt
:map :tn :tabnew<space>

" toggle paste setting
:map <C-p> :set paste!<CR>

" add # comments to a visual block
:map ,# :s/^/#/<CR>

" add // comments
:map ,/ :s/^/\/\//<CR>

" drop out to a shell in the current directory
:map <F9> <Esc>:shell<CR>

" abbreviations and common typos
ab teh the
ab nwe new
ab serach search
:map :W :w
:map :Q :q

" Don't use bells.
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

set t_Co=256
colorscheme molokai

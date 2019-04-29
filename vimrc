execute pathogen#infect()
filetype on
filetype plugin on
syntax on
colorscheme Tomorrow-Night
set guifont=Menlo\regular:h18
"set lines=50 columns=150
set colorcolumn=90
set number
let mapleader=","
map <leader>s :source ~/.vimrc<CR>
set hidden
set history=100
filetype indent on
"set nowrap
set tabstop=2"
set shiftwidth=2
set expandtab
set smartindent
set autoindent
autocmd BufWritePre * :%s/\s\+$//e
set hlsearch
nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>
nnoremap <Leader><Leader> :e#<CR>
set showmatch
set bs=2


set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

autocmd vimenter * NERDTree
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"

let g:go_fmt_command = "goimports"
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#gocode_binary = "~/go/bin/gocode"

" Terminal Function
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

" Toggle terminal on/off (neovim)
nnoremap <A-t> :call TermToggle(12)<CR>
inoremap <A-t> <Esc>:call TermToggle(13)<CR>
tnoremap <A-t> <C-\><C-n>:call TermToggle(13)<CR>

" Terminal go back to normal mode
tnoremap <Esc> <C-\><C-n>
tnoremap :q! <C-\><C-n>:q!<CR>


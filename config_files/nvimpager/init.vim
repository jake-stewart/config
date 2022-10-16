"
"  _   _       _                                       
" | \ | |_   _(_)_ __ ___  _ __   __ _  __ _  ___ _ __ 
" |  \| \ \ / / | '_ ` _ \| '_ \ / _` |/ _` |/ _ \ '__|
" | |\  |\ V /| | | | | | | |_) | (_| | (_| |  __/ |   
" |_| \_| \_/ |_|_| |_| |_| .__/ \__,_|\__, |\___|_|   
"                         |_|          |___/           
"

" SETTINGS {{{

set termguicolors                   " enable truecolor
set foldmethod=marker               " use {{{ and }}} for folding
set clipboard^=unnamed,unnamedplus  " make vim use system clipboard
set lazyredraw                      " run macros without updating screen
set encoding=utf-8                  " unicode characters
set ttimeoutlen=1                   " time waited for terminal codes
set guioptions=c!                   " remove gvim widgets
set noshowmode                      " hide --INSERT--
set laststatus=0                    " hide statusbar
set belloff=all                     " disable sound
set noswapfile                      " disable the .swp files vim creates
set title                           " set window title according to titlestring
set titlestring=%t%(\ %M%)          " title, modified
set splitright                      " open horizontal splits to the right
set splitbelow                      " open vertical splits below
set mouse=a                         " enable mouse
set mousemodel=extend               " remove right click menu
set noruler                         " hide commandline ruler
set rulerformat=%l,%c%V%=%P         " same syntax as statusline
set hlsearch                        " highlight search matches
set incsearch                       " show matches while typing
set ignorecase                      " case insensitive search
set smartcase                       " match case when query contains uppercase
set tabstop=8                       " tabs are 8 characters wide
set expandtab                       " expand tabs into spaces
set shiftwidth=4                    " num spaces for tab at start of line
set softtabstop=1                   " num spaces for tab within a line
set smarttab                        " differentiate shiftwidth and softtabstop

" }}}
" APPEARANCE {{{

set background=dark
syntax on
colorscheme custom

hi Comment gui=italic cterm=italic
hi Todo gui=italic cterm=italic

" }}}
" HIDE CURSOR {{{

hi Cursor blend=100
set guicursor+=a:Cursor/lCursor

" make cursor come back when in terminal/command line mode
au VimSuspend * set t_ve&vim
au BufWinEnter,WinEnter * set guicursor+=a:Cursor/lCursor
au CmdLineEnter * set guicursor-=a:Cursor/lCursor
au CmdLineLeave * set guicursor+=a:Cursor/lCursor

" }}}
" LESS-LIKE SEARCH {{{

function! MapSearch()
    cnoremap <silent><cr> <cr>:call UnmapSearch()<cr>zt$
    cnoremap <silent><esc> <c-c>:call UnmapSearch()<cr>
endf

function! UnmapSearch()
    cunmap <cr>
    cunmap <esc>
endf

" }}}
" KEYBINDS {{{

" keybinds are performed upon a VimEnter event
" this is to avoid nvimpager overwriting our keybinds
au VimEnter * call FixVimpager()
function FixVimpager()

    " stop this function running again
    au! VimEnter

    " make search only match once per line
    noremap / :<c-u>call MapSearch()<cr>/
    nnoremap n nzt:echo<CR>$
    nnoremap N Nzt:echo<CR>$
    xnoremap n nzt:echo<CR>$
    xnoremap N Nzt:echo<CR>$

    " ctrl + c quits program
    cnoremap <silent><c-c> <cmd>qa!<CR>
    nnoremap <silent><c-c> <cmd>qa!<CR>

    " clear search highlight
    nnoremap <silent><esc> :noh<CR>

    " bind u/d to ctrl+u/d
    nnoremap <buffer>d     <c-d>
    nnoremap u             <c-u>

    " unmap unused keys
    let l:unmap_keys = [
            \ "a", "b", "c", "d", "e", "h", "i", "l",
            \ "m", "o", "p", "r", "s", "t", "v", "w",
            \ "x", "y", "z", "A", "B", "C", "D", "E",
            \ "F", "H", "I", "J", "K", "L", "M", "O",
            \ "P", "Q", "R", "S", "T", "U", "V", "W",
            \ "X", "Y", "Z", "1", "2", "3", "4", "5",
            \ "6", "7", "8", "9", "0", "-", "=", "[",
            \ "]", ";", "'", ",", ".", "`", "@", "#",
            \ "$", "%", "^", "&", "*", "(", ")", "_",
            \ "+", "{", "}", "<", ">", "~", "<!>",
            \ "<bslash>", "<bar>", "\""
        \ ]
    for l:key in l:unmap_keys
        exe 'noremap ' . l:key . ' <NOP>'
    endfor

endfunction

" }}}

" vim: foldmethod=marker

"
"  _   _                 _           
" | \ | | ___  _____   _(_)_ __ ___  
" |  \| |/ _ \/ _ \ \ / / | '_ ` _ \ 
" | |\  |  __/ (_) \ V /| | | | | | |
" |_| \_|\___|\___/ \_/ |_|_| |_| |_|
"

" SETTINGS {{{1

let mapleader=" "

set termguicolors                   " enable truecolor
set foldmethod=marker               " use {{{ and }}} for folding
set lazyredraw                      " run macros without updating screen
set clipboard^=unnamed,unnamedplus  " make vim use system clipboard
set encoding=utf-8                  " unicode characters
set hidden                          " allow buffer switching without saving
set backspace=indent,eol,start      " make backspace work as expected
set ttimeoutlen=1                   " time waited for terminal codes
set shortmess+=I                    " remove start page
set showmatch                       " show matching brackets
set guioptions=c!                   " remove gvim widgets
set noshowmode                      " hide --insert--
set laststatus=0                    " hide statusbar
set cursorline                      " highlight current line
set belloff=all                     " disable sound
set nojoinspaces                    " stop double space when joining sentences
set noswapfile                      " disable the .swp files vim creates
set updatetime=300                  " quicker cursorhold events
set title                           " set window title according to titlestring
set titlestring=%t%(\ %M%)          " title, modified
set splitright                      " open horizontal splits to the right
set splitbelow                      " open vertical splits below
set mouse=a                         " enable mouse
set mousemodel=extend               " remove right click menu
set noruler                         " hide commandline ruler
set rulerformat=%l,%c%v%=%p         " same syntax as statusline
set number                          " show number column
set signcolumn=number               " both sign and number in number column
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
" COLORSCHEME {{{

set background=dark
syntax on
colorscheme custom

" }}}
" UNDO HISTORY {{{

set undofile                        " keep track of undo after quitting vim
set undodir=~/.config/nvim/undodir  " store undo history in nvim config
set undolevels=5000                 " increase undo history

if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p", 0770)
endif

" }}}
" AUTOCOMMANDS {{{

function RemoveAutoCommenting()
    setlocal fo-=c fo-=r fo-=o
endfunction
autocmd filetype * call RemoveAutoCommenting()

function RestoreCursorPosition()
    if line("'\"") > 0 && line("'\"") <= line("$")
        exe "normal g'\""
    endif
endfunction
autocmd BufReadPost * call RestoreCursorPosition()

" }}}
" MAPPINGS {{{1

" zero width space digraph
exe 'digraph zs ' . 0x200b

" toggle cursor column
nnoremap <silent><leader>c :let &cuc = !&cuc<cr>

" toggle color column
nnoremap <silent><leader>8 :let &cc = &cc == 0 ? 80 : 0<cr>

" automatically create open and close brace
inoremap <c-b> <esc>a <esc>ciw {<cr>}<esc>o

" visually select pasted content
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" swap indent with line below
nnoremap <silent><space>s ^dj^v$hpk$p

" clear search highlight
nnoremap <silent><esc> :noh<cr>

" go to start and end of line
noremap gh ^
noremap gl $

" make Y act like D and C
nnoremap Y y$

" easily replace macro with q
nnoremap Q @q

" }}}
" VIRTIDX {{{
function! VirtIdx(string, idx)
    if len(a:string) == 0
        return ' '
    endif
    let l:idx = 0
    for char in a:string
        if char == "\t"
            let l:idx = (l:idx / &ts + 1) * &ts
        else
            let l:idx += strdisplaywidth(char)
        endif

        if l:idx >= a:idx
            break
        endif
    endfor
    return char
endfunction

" }}}
" SLIDE {{{

function! Slide(direction, smart_syntax)
    let l:syntax = a:smart_syntax && exists("*synstack")

    let l:col = col('.')
    let l:line = line('.')
    let l:max_line = line('$')

    if l:syntax
        let l:stack = synstack(line('.'), col('.'))
    endif

    if l:col > 1
        let l:char_before = VirtIdx(getline(l:line), l:col - 1)
        let l:space_before = (l:char_before == ' '
                    \ || l:char_before == ''
                    \ || l:char_before == "\t")
    endif

    let l:char_after = VirtIdx(getline(l:line), l:col)
    let l:space_after = (l:char_after == ' '
                \ || l:char_after == ''
                \ || l:char_after == "\t")

    while 1
        let l:line += a:direction

        if l:line > l:max_line || l:line == 0
            break
        endif

        if strdisplaywidth(getline(l:line)) < l:col - 1
            break
        endif

        if l:syntax
            let l:newstack = synstack(l:line, l:col)
            if len(l:newstack) == 0
                if len(l:stack) > 0
                    let g:bruh = 1
                    break
                endif
            elseif len(l:stack) == 0
                let g:bruh = 2
                break
            elseif l:stack[-1] != l:newstack[-1]
                let g:bruh = 3
                break
            endif
        endif

        let l:char_after = VirtIdx(getline(l:line), l:col)
        let l:new_space_after = (l:char_after == ' '
                    \ || l:char_after == ''
                    \ || l:char_after == "\t")
        if l:new_space_after != l:space_after
            break
        endif

        if l:col > 1
            let l:char_before = VirtIdx(getline(l:line), l:col - 1)
            let l:new_space_before = (l:char_before == ' '
                        \ || l:char_before == ''
                        \ || l:char_before == "\t")
            if l:new_space_before != l:space_before
                break
            endif
        endif
    endwhile

    if a:direction == 1
        let l:jump = l:line - line('.') - 1
        let l:jump_char = 'j'
    else
        let l:jump = line('.') - l:line - 1
        let l:jump_char = 'k'
    endif

    if l:jump == 0
        return ''
    elseif l:jump == 1
        return l:jump_char
    else
        return l:jump . l:jump_char
    endif
endfunction

nnoremap <expr><leader>j Slide(1, 0)
vnoremap <expr><leader>j Slide(1, 0)
nnoremap <expr><leader>k Slide(-1, 0)
vnoremap <expr><leader>k Slide(-1, 0)

nnoremap <expr><leader>j Slide(1, 1)
vnoremap <expr><leader>j Slide(1, 1)
nnoremap <expr><leader>k Slide(-1, 1)
vnoremap <expr><leader>k Slide(-1, 1)

" }}}
" PLUGINS {{{

call plug#begin()
Plug 'tpope/vim-repeat'
Plug 'kylechui/nvim-surround'
Plug 'vimjas/vim-python-pep8-indent'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-abolish'
Plug 'chaoren/vim-wordmotion'
Plug 'andrewradev/splitjoin.vim'
Plug 'machakann/vim-swap', { 'on': '<plug>(swap-interactive)' }
Plug 'kevinhwang91/nvim-bqf', { 'for': 'qf' }
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-line'
Plug 'glts/vim-textobj-comment'
Plug 'michaeljsmith/vim-indent-object'
Plug 'junegunn/vim-easy-align', { 'on': '<plug>(EasyAlign)' }
Plug 'uiiaoo/java-syntax.vim', { 'for': 'java' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" }}}
" NETRW SETTINGS {{{

let g:netrw_banner=0

" }}}
" JAVA HIGHLIGHT SETTINGS {{{

highlight link javatype none
highlight link javatype none
highlight link javaidentifier none
highlight link javadelimiter none

" }}}
" COC SETTINGS {{{

nmap <silent> gd <plug>(coc-definition)
nmap <silent> gy <plug>(coc-type-definition)
nmap <silent> gi <plug>(coc-implementation)
nmap <silent> gr <plug>(coc-references)
nnoremap <silent> K :call ShowDocumentation()<cr>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

inoremap <silent><expr> <tab>
      \ pumvisible() ? "\<c-n>" :
      \ CheckBackspace() ? "\<tab>" :
      \ coc#refresh()
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<c-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-j>
            \ coc#refresh() . CocActionAsync('showSignatureHelp')

inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<cr>"

xmap if <plug>(coc-funcobj-i)
omap if <plug>(coc-funcobj-i)
xmap af <plug>(coc-funcobj-a)
omap af <plug>(coc-funcobj-a)
xmap ic <plug>(coc-classobj-i)
omap ic <plug>(coc-classobj-i)
xmap ac <plug>(coc-classobj-a)
omap ac <plug>(coc-classobj-a)

" }}}
" EASY ALIGN SETTINGS {{{

xnoremap ga <plug>(EasyAlign)
nnoremap ga <plug>(EasyAlign)

" }}}
" SURROUND SETTINGS {{{

lua require("nvim-surround").setup()

" }}}
" SWAP SETTINGS {{{

nmap gs <plug>(swap-interactive)

" }}}
" WORDMOTION SETTINGS {{{

let g:wordmotion_prefix = "<space>"

" }}}
" SPLITJOIN SETTINGS {{{

let g:splitjoin_r_indent_align_args = 0
let g:splitjoin_python_brackets_on_separate_lines = 1
let g:splitjoin_html_attributes_hanging = 1

"}}}
" JFIND {{{
function! OnJFindExit(window, status)
    call nvim_win_close(a:window, 0)
    if a:status == 0
        try
            let l:contents = readfile($HOME . "/.cache/jfind_out")
            exe 'edit ' . l:contents[0]
        catch
            return
        endtry
    endif
endfunction

function! JFind()
    let project = system('~/.config/jfind/jfind-match-project.sh')
    if project == ""
        echo "Unknown project: " . getcwd()
        return
    endif
    let width = float2nr(&columns * 0.9)
    let height = float2nr(&lines * 0.7)

    let buf = nvim_create_buf(v:false, v:true)

    let ui = nvim_list_uis()[0]
    let opts = {'relative': 'editor',
                \ 'width': width,
                \ 'height': height,
                \ 'col': (ui.width/2) - (width/2),
                \ 'row': (ui.height/2) - (height/2),
                \ 'anchor': 'nw',
                \ 'style': 'minimal',
                \ 'border': 'rounded',
                \ }

    let win = nvim_open_win(buf, 1, opts)
    call nvim_win_set_option(win, 'winhl', 'normal:normal')
    let t = termopen('~/.config/jfind/jfind-project.sh',
                \ {'on_exit': {status, data -> OnJFindExit(win, data)}})
    startinsert
endfunction

nnoremap <silent><c-f> :call JFind()<cr>

" }}}
" FORCE GO FILE {{{

function! ForceGoFile(fname)
    let l:path=expand('%:p:h') .'/'. expand(a:fname)
    if filereadable(l:path)
       norm gf
    else
        silent! execute "!touch ". expand(l:path)
        norm gf
    endif
endfunction

noremap <silent><leader>gf :call ForceGoFile(expand("<cfile>"))<cr>

" }}}

" vim: foldmethod=marker

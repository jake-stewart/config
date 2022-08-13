"  _       _ _               _           
" (_)_ __ (_) |_      __   _(_)_ __ ___  
" | | '_ \| | __|     \ \ / / | '_ ` _ \ 
" | | | | | | |_   _   \ V /| | | | | | |
" |_|_| |_|_|\__| (_)   \_/ |_|_| |_| |_|

" Settings {{{1
let mapleader=" "

" title
set title
set titlestring=%t%(\ %M%)%(\ %a%)

" set rulerformat=%17(%c%V\ %p%%%)
set rulerformat=%l,%c%V%=%P

" colorscheme
set background=dark
set termguicolors
syntax on
colorscheme custom

set shortmess+=I   " remove start page
set showmatch
set guioptions=c!  " remove gvim widgets
set noshowmode     " hide --INSERT--
set laststatus=0   " hide statusbar
set noruler
set number
set cursorline
set belloff=all    " disable sound
set showmatch
set nojoinspaces   " stop double space when joining sentences

set noswapfile
set updatetime=300

" splits
set splitright
set splitbelow

" whitespace
set tabstop=8
set expandtab
set softtabstop=4
set shiftwidth=4
set smarttab

" undo
if !isdirectory($HOME."/.config/nvim/undodir")
    call mkdir($HOME."/.config/nvim/undodir", "p", 0770)
endif
set undodir=~/.config/nvim/undodir
set undofile
set undolevels=5000

" searching
set hlsearch
set incsearch
set smartcase
set ignorecase

" other
set foldmethod=marker               " use {{{ and }}} for folding
set lazyredraw                      " run macros without updating screen
set clipboard^=unnamed,unnamedplus  " make vim use system clipboard
set encoding=utf-8                  " unicode characters
set hidden                          " allow buffer switching without saving
set backspace=indent,eol,start      " make backspace work as expected
set mouse=a                         " enable mouse
set ttimeoutlen=1                   " time waited for terminal codes
set signcolumn=number

" Autocommands {{{1
function RemoveAutoCommenting()
    setlocal fo-=c fo-=r fo-=o
endfunction
autocmd FileType * call RemoveAutoCommenting()

function RestoreCursorPosition()
    if line("'\"") > 0 && line("'\"") <= line("$")
        exe "normal g'\""
    endif
endfunction
autocmd BufReadPost * call RestoreCursorPosition()

" Mappings {{{1

" zero width space
exe 'digraph zs ' . 0x200b

nnoremap Q @q

nnoremap <c-t> :tabnew<CR>

function ToggleCursorColumn()
    if &cursorcolumn
        set nocursorcolumn
    else
        set cursorcolumn
    endif
endfunction
nnoremap <silent><leader>c :call ToggleCursorColumn()<CR>

nnoremap <silent><esc> :noh<CR>

nnoremap $ <NOP>
nnoremap ^ <NOP>
nnoremap 0w $

nnoremap <m-l> gt
nnoremap <m-h> gT
nnoremap <silent><m-L> :tabm +1<CR>
nnoremap <silent><m-H> :tabm -1<CR>

tnoremap <m-l> <c-\><c-n>gt
tnoremap <m-h> <c-\><c-n>gT
tnoremap <silent><m-L> <c-\><c-n>:tabm +1<CR>a
tnoremap <silent><m-H> <c-\><c-n>:tabm -1<CR>a

nnoremap <c-w><c-m> <c-w>j

nnoremap <c-l> <c-w><c-w>
tnoremap <c-l> <c-\><c-n><c-w><c-w>

tmap <c-w> <c-\><c-n><c-w>

noremap gh ^
noremap gl $

nnoremap Y y$
nnoremap Q @q

inoremap  <esc>A <esc>ciw {<CR>}<esc>O

let g:splitjoin_r_indent_align_args = 0
let g:splitjoin_python_brackets_on_separate_lines = 1
let g:splitjoin_html_attributes_hanging = 1

" Terminal {{{
augroup TERMINAL_OPTIONS
  autocmd!
  autocmd TermOpen  * startinsert | setlocal nonu
  autocmd TermEnter * startinsert
  autocmd BufWinEnter,WinEnter term://* startinsert
augroup END

" VirtIdx() {{{1
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

" Slide() {{{1
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
        let l:space_before = (l:char_before == ' ' || l:char_before == '' || l:char_before == '	')
    endif

    let l:char_after = VirtIdx(getline(l:line), l:col)
    let l:space_after = l:char_after == ' ' || l:char_after == '' || l:char_after == '	'

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
        let l:new_space_after = l:char_after == ' ' || l:char_after == '' || l:char_after == '	'
        if l:new_space_after != l:space_after
            break
        endif

        if l:col > 1
            let l:char_before = VirtIdx(getline(l:line), l:col - 1)
            let l:new_space_before = (l:char_before == ' ' || l:char_before == '' || l:char_before == '	')
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

nnoremap <expr><leader>J Slide(1, 1)
vnoremap <expr><leader>J Slide(1, 1)
nnoremap <expr><leader>K Slide(-1, 1)
vnoremap <expr><leader>K Slide(-1, 1)


" Plugins {{{1
call plug#begin()
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'tpope/vim-commentary'
Plug 'ggandor/leap.nvim'
Plug 'tpope/vim-abolish'
Plug 'chaoren/vim-wordmotion'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'machakann/vim-swap', { 'on': '<plug>(swap-interactive)' }
Plug 'kevinhwang91/nvim-bqf', { 'for': 'qf' }
Plug 'vim-scripts/ReplaceWithRegister',
            \ {'on': [ '<Plug>ReplaceWithRegisterOperator',
                     \ '<Plug>ReplaceWithRegisterLine',
                     \ '<Plug>ReplaceWithRegisterVisual' ]}
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-line'
Plug 'glts/vim-textobj-comment'
Plug 'michaeljsmith/vim-indent-object'
Plug 'junegunn/vim-easy-align', { 'on': '<Plug>(EasyAlign)' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'uiiaoo/java-syntax.vim', { 'for': 'java' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" Java Highlight Settings {{{1
highlight link javaType NONE
highlight link javaType NONE
highlight link javaIdentifier NONE
highlight link javaDelimiter NONE

" Coc Settings {{{1
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Easy Align Settings {{{1
xnoremap ga <plug>(EasyAlign)
nnoremap ga <plug>(EasyAlign)

" Swap Settings {{{1
nmap gs <Plug>(swap-interactive)

" Wordmotion Settings {{{1
let g:wordmotion_prefix = "<space>"

" Replace With Register Settings {{{1
nmap gp  <Plug>ReplaceWithRegisterOperator
nmap gpp <Plug>ReplaceWithRegisterLine
xmap gp  <Plug>ReplaceWithRegisterVisual

" Leap Settings {{{1
nmap m <plug>(leap-forward)
nmap M <plug>(leap-backward)
lua << EOF
    require('leap').setup {
         case_insensitive = true,
         safe_labels = {},
         labels = {
             'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'j', 'i', 'k', 'l', 'm',
             'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
             '1', '2', '3', '4', '5', '7', '8', '9', '0',
             ';', "'", ',', '.', '/', 
             'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'I', 'K', 'L', 'M',
             'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
             ':', '"', '<', '>', '?', 
         }
    }
EOF

" BQF Settings {{{1
let $BAT_THEME='custom'

" FZF Settings {{{1
command! -bang -nargs=* -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': [
        \ '--delimiter', '/',
        \ '--with-nth', '-2..',
        \ '--preview',
        \ '~/.vim/plugged/fzf.vim/bin/preview.sh {}'
    \ ]}, <bang>0)

" jfind {{{1

function! OnJFindExit(window, status)
    call nvim_win_close(a:window, 0)
    if a:status == 0
        try
            let l:contents = readfile($HOME . "/.cache/fcd_dest")
            exe 'edit ' . l:contents[0]
        catch
            return
        endtry
    endif
endfunction

function! JFind()
    let width = float2nr(&columns * 0.9)
    let height = float2nr(&lines * 0.7)
    " let width = float2nr(winwidth(0) * 0.9)
    " let height = float2nr(winheight(0) * 0.7)

    let buf = nvim_create_buf(v:false, v:true)

    let ui = nvim_list_uis()[0]
    let opts = {'relative': 'editor',
                \ 'width': width,
                \ 'height': height,
                \ 'col': (ui.width/2) - (width/2),
                \ 'row': (ui.height/2) - (height/2),
                \ 'anchor': 'NW',
                \ 'style': 'minimal',
                \ 'border': 'rounded',
                \ }
    let win = nvim_open_win(buf, 1, opts)

    call nvim_win_set_option(win, 'winhl', 'Normal:Normal')
    
    let t = termopen('fcd --project="' . getcwd() . '"',
                \ {'on_exit': {status, data -> OnJFindExit(win, data)}})
endfunction


nnoremap <silent><C-f> :call JFind()<CR>

" vim: foldmethod=marker

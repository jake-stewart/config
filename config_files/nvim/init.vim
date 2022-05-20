let mapleader=" "

" title
set title
set titlestring=%t%(\ %M%)%(\ %a%)

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
set ruler
set number
set cursorline
set belloff=all    " disable sound
set showmatch
set nojoinspaces   " stop double space when joining sentences

set noswapfile

" splits
set splitright
set splitbelow

" whitespace
set tabstop=8
set expandtab
set softtabstop=4
set shiftwidth=4
set smarttab

let $BAT_THEME='custom'

if !isdirectory($HOME."/.config")
    call mkdir($HOME."/.config", "", 0770)
endif
if !isdirectory($HOME."/.config/nvim")
    call mkdir($HOME."/.config/nvim", "", 0770)
endif
if !isdirectory($HOME."/.config/nvim/undodir")
    call mkdir($HOME."/.config/nvim/undodir", "", 0700)
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

nnoremap <silent>t :noh<CR>
nnoremap Q @q
nnoremap <silent><leader>c :exec &cuc ? "set nocuc" : "set cuc"<CR>

autocmd FileType * setlocal fo-=c fo-=r fo-=o  " remove autocommenting

" go to last position before exiting vim
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

exe 'digraph zs ' . 0x200b

nnoremap <silent>t :noh<CR>
nnoremap <silent><esc> :noh<CR>

nnoremap <c-d> 10jzz
nnoremap <c-u> 10kzz

map gh ^
map gl $

nnoremap Y y$
nnoremap Q @q

" inoremap {<CR> {<cr>}<esc>O
inoremap  <esc>A <esc>ciw {<CR>}<esc>O


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

function! FastJump()
    while 1
        let l:char = getcharstr()
        if l:char == "\<esc>"
            break
        elseif l:char == "\<CR>"
            break
        endif
    endwhile
endfunction

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

lua << EOF
require("packer").startup({
    function(use)
        use({
            "wbthomason/packer.nvim",
            "tpope/vim-repeat",
            {
                "tpope/vim-commentary",
                keys = "gc",
            },
            {
                "tpope/vim-surround",
                keys = "ys"
            },
            {
                 'ggandor/leap.nvim',
                 keys = { "m", "M" },
                 config = function()
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
                     vim.keymap.set('n', 'm', '<plug>(leap-forward)')
                     vim.keymap.set('n', 'M', '<plug>(leap-backward)')
                 end
            },
            {
                'chaoren/vim-wordmotion',
                setup = function()
                    vim.g.wordmotion_prefix = "<space>"
                end
            },

            {
                "mfussenegger/nvim-jdtls",
                event = "Filetype java",
                config = function()
                    local config = {
                      cmd = {
                          'jdtls',
                          '-configuration', '/usr/local/opt/jdtls/libexec/config_mac',
                          '-data', '/Users/jake/.cache/jdtls_workspace/'
                      },
                      root_dir = require('jdtls.setup').find_root({'mvnw', '.git', 'gradlew'}),
                    }
                    config['on_attach'] = function(client, bufnr)
                        local opts = { noremap=true }
                        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
                        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
                        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
                        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
                        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
                        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
                        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
                        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
                        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
                        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
                        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
                        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
                        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
                    end
                    vim.g.start_jdtls = function()
                        require('jdtls').start_or_attach(config)
                    end
                    vim.cmd([[
                        au Filetype java call g:start_jdtls()
                    ]])
                end
            },

            {
                "machakann/vim-swap",
                keys = "gs"
            },

            {
                "kevinhwang91/nvim-bqf",
                ft = "qf"
            },
            {
                "vim-scripts/ReplaceWithRegister",
                keys = "gr"
            },
            {
                "kana/vim-textobj-entire",
                requires = { "kana/vim-textobj-user" }
            },
            {
                "kana/vim-textobj-line",
                requires = { "kana/vim-textobj-user" }
            },
            {
                "glts/vim-textobj-comment",
                requires = { "kana/vim-textobj-user" }
            },

            --{
            --  "neovim/nvim-lspconfig",
            --  event = "FileType *.bruh",
            --  config = function()
            --      require('lspconfig').jdtls.setup {
            --          cmd = {
            --              'jdtls',
            --              '-configuration', '/usr/local/opt/jdtls/libexec/config_mac',
            --              '-data', '/Users/jake/.cache/jdtls_workspace/'
            --          },
            --          on_attach = on_attach,
            --          flags = {
            --              -- This will be the default in neovim 0.7+
            --              debounce_text_changes = 150,
            --          }
            --      }
            --  end
            --},

            {
                "junegunn/vim-easy-align",
                keys = {"ga"},
                config = function()
                    vim.keymap.set('x', 'ga', '<plug>(EasyAlign)')
                    vim.keymap.set('n', 'ga', '<plug>(EasyAlign)')
                end
            },
            {
                'junegunn/fzf',
                keys = "<C-f>",
                run = function()
                    vim.cmd([[
                        fzf#install()
                    ]])
                end
            },
            {
                "junegunn/fzf.vim",
                after = 'fzf',
                config = function()
                    vim.cmd([[
                        command! -bang -nargs=* -complete=dir Files
                            \ call fzf#vim#files(<q-args>, {'options': [
                                \ '--delimiter', '/',
                                \ '--with-nth', '-2..',
                                \ '--preview',
                                \ '~/.vim/plugged/fzf.vim/bin/preview.sh {}'
                            \ ]}, <bang>0)
                    ]])
                    vim.keymap.set('n', '<C-f>', ':Files<CR>')
                end,
            },
            {
                "ms-jpq/coq_nvim",
                event = "Filetype java",
                setup = function()
                    vim.cmd([[
                        let g:coq_settings = { 'display.pum.fast_close': v:false }
                    ]])
                end,
                config = function()
                    vim.cmd([[
                        COQnow [--shut-up]
                    ]])
                end
            },
            {
                "nvim-treesitter/nvim-treesitter",
                event = "Filetype java",
                run = function()
                    vim.cmd([[TSUpdate]])
                end,
                config = function()
                    require'nvim-treesitter.configs'.setup {
                        ensure_installed = { "java", "cpp", "python" },
                        sync_install = false,
                        ignore_install = { },
                        highlight = {
                            enable = true,
                            disable = { },
                            additional_vim_regex_highlighting = false,
                        },
                    }
                end
            },
        })
    end,
})

EOF

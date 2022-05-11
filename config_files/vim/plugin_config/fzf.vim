" ignore .gitignore shit
" let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'

nnoremap  :Buffers<cr>
nnoremap  :FZF<cr>

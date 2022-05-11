function! ShowFileInfo()
    echo expand("%:p:h:h:t") . "/" . expand("%:p:h:t") . "/" . expand("%:p:t")
endfunction

au BufWinEnter * call ShowFileInfo()
nmap <silent><leader>o :<C-u>silent! call EnhancedJumps#Jump(0,'remote')<CR>:call ShowFileInfo()<CR>
nmap <silent><leader>i :<C-u>silent! call EnhancedJumps#Jump(1,'remote')<CR>:call ShowFileInfo()<CR>

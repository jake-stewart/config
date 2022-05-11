function SmartQuit()
    try
        quit
    catch
        try
            wq
        catch
            if expand("%p") == ""
                write! ~/.cache/vim-force-quit-backup
                quit!
            else
                echoerr "Failed to write file '" . expand("%p") . "'."
            endif
        endtry
    endtry
endfunction

nnoremap ,q :call SmartQuit()<CR> 
nnoremap <silent>,w :w<CR>

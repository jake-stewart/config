function! FCD()
    try
        exe 'silent !fcd --project="' . expand("%:p:h") . '"'
        let g:k = readfile("/users/jake/.cache/fcd_dest")
        if len(g:k) == 1
            execute "edit " . g:k[0]
        endif
    catch /.*/
        return
    finally
        redraw!
    endtry
endfunction

nnoremap  :call FCD()<CR>

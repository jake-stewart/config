function! SynStack()
    if !exists("*synstack")
        return
    endif
    return map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction

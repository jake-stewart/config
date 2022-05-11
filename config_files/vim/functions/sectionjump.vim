function! IsComment()
    if !exists("*synstack")
        return 0
    endif
    redraw
    let l:stack = map(synstack(line("."), indent(line(".")) + 1), 'synIDattr(v:val, "name")')
    for l:i in range(len(l:stack))
        if l:stack[l:i] =~ ".*Comment.*"
            return 1
        endif
    endfor
    return 0
endfunction

function! GoForwardSection()
    let l:empty = 0
    while 1
        norm j

        if line(".") >= line("$")
            break
        endif

        if IsComment()
            let l:empty = 1
            continue
        endif

        if trim(getline(line("."))) == ""
            let l:empty = 1
            continue
        endif

        if l:empty
            break
        endif

        let l:indent = indent(line("."))
        if l:indent < indent(line(".") + 1)
            break
        endif
    endwhile
endfunction

function! GoBackSection()
    let l:start_line = line(".") - 1
    while 1
        norm k

        if line(".") == 1
            return
        endif

        if IsComment()
            if line(".") == l:start_line
                let l:start_line = line(".") - 1
                continue
            else
                norm j
                return
            endif
        endif

        if trim(getline(line(".") - 1)) == ""
            if line(".") == l:start_line
                let l:start_line = line(".") - 1
                continue
            else
                break
            endif
        endif

        if trim(getline(line("."))) == ""
            if line(".") == l:start_line
                let l:start_line = line(".") - 1
            endif
            continue
        endif

        let l:indent = indent(line("."))
        if l:indent < indent(line(".") + 1)
            break
        endif
    endwhile
endfunction

vnoremap <silent><cr> :call GoForwardSection()<CR>^
nnoremap <silent><cr> :call GoForwardSection()<CR>^
onoremap <silent><cr> :call GoForwardSection()<CR>^
vnoremap <silent>   :call GoBackSection()<CR>^
nnoremap <silent>   :call GoBackSection()<CR>^
onoremap <silent>   :call GoBackSection()<CR>^

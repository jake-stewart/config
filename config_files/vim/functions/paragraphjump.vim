function! GoStartParagraph()
    call cursor(0, 1)
    let l:start_line = line('.')
    let l:line = search("\\v(^\\s*\\n|%^)\\zs\\s*\\S+.*$", "Wb")
    let l:diff = l:start_line - l:line
    if l:diff > 0
        return l:diff . 'k^'
    endif
    return ""
endfunction

function! GoEndParagraph()
    let l:start_line = line('.')
    let l:line = search("\\v\\s*\\S+.*\\ze(\\n\\s*$|%$)", "W")
    let l:diff = l:line - l:start_line
    if l:diff > 0
        return l:diff . 'j^'
    endif
    return ""
endfunction

vnoremap <silent><expr><cr> GoEndParagraph()
vnoremap <silent><expr>   GoStartParagraph()
nnoremap <silent><expr><cr> GoEndParagraph()
nnoremap <silent><expr>   GoStartParagraph()
onoremap <silent><expr><cr> GoEndParagraph()
onoremap <silent><expr>   GoStartParagraph()

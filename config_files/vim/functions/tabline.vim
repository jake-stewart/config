function TabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    let l:name = bufname(buflist[winnr - 1])
    if l:name == ""
        let l:name = "[No Name]"
    else

        let l:words = split(l:name, '/')
        if len(l:words) == 1
            let l:name = "/" . words[0]
        else
            let l:name = words[-2] . "/" . words[-1]
        endif
    endif

    if getbufvar(buflist[winnr - 1], "&modified")
        let l:name .= " +"
    endif
    return l:name
endfunction

function TabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        " select the highlighting
        if i + 1 == tabpagenr()
            let s ..= '%#TabLineSel#'
        else
            let s ..= '%#TabLine#'
        endif

        " set the tab page number (for mouse clicks)
        let s ..= '%' .. (i + 1) .. 'T'

        " the label is made by TabLabel()
        let s ..= ' %{TabLabel(' .. (i + 1) .. ')} '

    endfor

    " after the last tab fill with TabLineFill and reset tab page nr
    let s ..= '%#TabLineFill#%T'

    " right-align the label to close the current tab page
    if tabpagenr('$') > 1
        let s ..= '%=%#TabLine#%999X'
    endif

    return s
endfunction

set tabline=%!TabLine()

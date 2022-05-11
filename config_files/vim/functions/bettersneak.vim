

function GetSneak()
    echon ""
    let l:first = getcharstr()
    if l:first == "\<CR>"
        return ""
    elseif l:first == "\<esc>"
        return ""
    " elseif l:first =~ '\v(|)\[|\]|\{|\}'
    "     return "("
    elseif l:first == "\\"
        let l:first = "\\\\"
    endif
    let l:second = getcharstr()
    if l:second == "\<CR>"
        return l:first . "$"
    elseif l:second == "\<esc>"
        return ""
    elseif l:second == "\\"
        let l:second = "\\\\"
    endif
    return l:first . l:second
endfunction

function BetterSneakForward()
    let l:sneak = GetSneak()
    if l:sneak == ""
        return ""
    elseif l:sneak =~ '\v\C^[a-z]+$'
        return '/\v(<|_@<=)' . l:sneak . "\<CR>"
    else
        return "/" . l:sneak . "\<CR>"
    endif
endfunction

function BetterSneakBack()
    let l:sneak = GetSneak()
    if l:sneak == ""
        return ""
    elseif l:sneak =~ '\v\C^[a-z]+$'
        return '?\v(<|_@<=)' . l:sneak . "\<CR>"
    else
        return "?" . l:sneak . "\<CR>"
    endif
endfunction

nnoremap <silent><expr>m BetterSneakForward()
nnoremap <silent><expr>M BetterSneakBack()

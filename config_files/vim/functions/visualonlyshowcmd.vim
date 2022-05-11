function VisualOnlyShowCmd()
    if mode() =~# '^[vV\x16]'
        set showcmd
    else
        set noshowcmd
    endif
endfunction

au ModeChanged [vV\x16]*:* call VisualOnlyShowCmd()
au ModeChanged *:[vV\x16]* call VisualOnlyShowCmd()
au WinEnter,WinLeave *     call VisualOnlyShowCmd()

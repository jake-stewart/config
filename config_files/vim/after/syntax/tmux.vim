function! CreateCommentHeadings(c)
    exe 'syn match CommentBlock ' .
        \ '/\v((\n|%^)\s*'.a:c.'\s*)+\n\s*'.a:c.'.*\ze\n(^\s*'.a:c.'.*\n)*^\s*'.a:c.'\s*(\n\n|%$)/'

    exe 'syn match CommentHeading ' .
        \ '/^'.a:c.'\s*\zs.*\ze$/ contained containedin=CommentBlock'

    hi link CommentBlock Comment

    if exists("g:CommentHeading")
        exe 'hi CommentHeading ' . g:CommentHeading
    else
        hi CommentHeading gui=bold cterm=bold
    endif
endfunction

call CreateCommentHeadings('#')

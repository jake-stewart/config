function! g:CreateCommentHeadings(comment_char, comment_syn)
   exe 'syn match CommentHeading ' 
               \ . '/\v' . a:comment_char . '\s*\zs([A-Z]{2,}|(([A-Z]+['."'".'"!():+?-]?|['."'".'"!():+?-]?[A-Z]+)\s*){2,})$/'
               \ . ' contained containedin=' . a:comment_syn
   if exists("g:CommentHeading")
       exe 'hi CommentHeading ' . g:CommentHeading
    else
       hi CommentHeading gui=underline cterm=underline
   endif
endfunction

call CreateCommentHeadings('"', 'vimLineComment,vimComment')

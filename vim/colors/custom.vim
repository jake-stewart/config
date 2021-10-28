hi Normal        guifg=#ABB2BF   guibg=#1B1B1B   gui=NONE
hi Conceal       guifg=#ABB2BF   guibg=NONE      gui=NONE
hi Cursor        guifg=#282C34   guibg=#ABB2BF   gui=NONE
hi CursorLine    guifg=NONE      guibg=#222222   gui=NONE cterm=NONE
hi CursorColumn  guifg=NONE      guibg=#2A2F39   gui=NONE
hi SignColumn    guifg=NONE      guibg=NONE      gui=NONE
hi FoldColumn    guifg=NONE      guibg=NONE      gui=NONE
hi VertSplit     guifg=#323232   guibg=#323232   gui=NONE
hi StatusLine    guifg=#ABB2BF   guibg=#323232   gui=NONE
hi StatusLineNC  guifg=#ABB2BF   guibg=#323232   gui=NONE
hi LineNr        guifg=#414756   guibg=NONE      gui=NONE
hi CursorLineNr  guifg=NONE      guibg=#222222   gui=NONE cterm=NONE
hi Folded        guifg=#5C6370   guibg=NONE      gui=NONE
hi IncSearch     guifg=#E5C07B   guibg=#5C6370   gui=NONE
hi Search        guifg=NONE      guibg=#343840   gui=NONE
hi ModeMsg       guifg=NONE      guibg=NONE      gui=NONE
hi NonText       guifg=#3E4452   guibg=NONE      gui=NONE
hi Question      guifg=#C678DD   guibg=NONE      gui=NONE
hi SpecialKey    guifg=#3B4048   guibg=NONE      gui=NONE
hi StatusLine    guifg=#ABB2BF   guibg=#333333   gui=NONE cterm=NONE
hi StatusLineNC  guifg=#5C6370   guibg=#333333   gui=NONE cterm=NONE
hi Title         guifg=#98C379   guibg=NONE      gui=bold
hi Visual        guifg=NONE      guibg=#333333   gui=NONE
hi WarningMsg    guifg=#E5C07B   guibg=NONE      gui=NONE
hi Underlined    guifg=NONE      guibg=NONE      gui=underline

hi Pmenu         guifg=NONE      guibg=#333333   gui=NONE
hi PmenuSel      guifg=#282C34   guibg=#61AFEF   gui=NONE

" dif
hi DiffDelete    guifg=#E06C75   guibg=#282C34   gui=NONE
hi DiffAdd       guifg=#98C379   guibg=#282C34   gui=NONE
hi DiffChange    guifg=#E5C07B   guibg=#282C34   gui=bold
hi DiffText      guifg=#282C34   guibg=#ABB2BF   gui=NONE

" vim sandwich
hi OperatorSandwichChange guifg=NONE      guibg=#3E4452   gui=NONE

" comment grey
hi Comment       guifg=#5C6370   guibg=NONE      gui=italic

" cyan
hi Constant      guifg=#56B6C2   guibg=NONE      gui=NONE

" dark yellow
hi Float         guifg=#D19A66   guibg=NONE      gui=NONE
hi Number        guifg=#D19A66   guibg=NONE      gui=NONE
hi Boolean       guifg=#D19A66   guibg=NONE      gui=NONE

" red
hi Identifier    guifg=#E06C75   guibg=NONE      gui=NONE
hi SpellBad      guisp=#E06C75   guibg=NONE      gui=undercurl
hi Keyword       guifg=#E06C75   guibg=NONE      gui=NONE
hi Error         guifg=#E06C75   guibg=NONE      gui=NONE
hi ErrorMsg      guifg=#E06C75   guibg=NONE      gui=NONE

hi PmenuSbar     guifg=#00FF00   guibg=NONE      gui=NONE

" green
hi String        guifg=#98C379   guibg=NONE      gui=NONE
hi Character     guifg=#98C379   guibg=NONE      gui=NONE

" yellow
hi PreProc       guifg=#E5C07B   guibg=NONE      gui=NONE
hi SpellCap      guisp=#E5C07B   guibg=NONE      gui=undercurl
hi PreCondit     guifg=#E5C07B   guibg=NONE      gui=NONE
hi StorageClass  guifg=#E5C07B   guibg=NONE      gui=NONE
hi Structure     guifg=#E5C07B   guibg=NONE      gui=NONE
hi Type          guifg=#E5C07B   guibg=NONE      gui=NONE

" blue
hi Special       guifg=#61AFEF   guibg=NONE      gui=NONE
hi WildMenu      guifg=#282C34   guibg=#61AFEF   gui=NONE
hi Include       guifg=#61AFEF   guibg=NONE      gui=NONE
hi Function      guifg=#61AFEF   guibg=NONE      gui=NONE

" purple
hi Todo          guifg=#C678DD   guibg=NONE      gui=NONE
hi Repeat        guifg=#C678DD   guibg=NONE      gui=NONE
hi Define        guifg=#C678DD   guibg=NONE      gui=NONE
hi Macro         guifg=#C678DD   guibg=NONE      gui=NONE
hi Statement     guifg=#C678DD   guibg=NONE      gui=NONE
hi Label         guifg=#C678DD   guibg=NONE      gui=NONE
hi Operator      guifg=#C678DD   guibg=NONE      gui=NONE
hi Exception     guifg=#C678DD   guibg=NONE      gui=NONE
hi MatchParen    guifg=#C678DD   guibg=NONE      gui=underline

hi default CocErrorSign    ctermfg=Red     guifg=#E06C75
hi default CocWarningSign  ctermfg=Brown   guifg=#ff922b

let g:terminal_ansi_colors = [
            \ "#282C34", "#F9929B", "#98C379", "#EBCB8B",
            \ "#81A1C1", "#B48EAD", "#88C0D0", "#D8DEE9",
            \ "#4C566A", "#BF616A", "#8FBCBB", "#FBDF90",
            \ "#81A1C1", "#D2B8ED", "#8FBCBB", "#D8DEE9"
            \]

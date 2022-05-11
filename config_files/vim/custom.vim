function! HL(name, fg, bg, style)
    exe 'hi ' . a:name .
                \ ' guifg=' . a:fg    . ' guibg=' . a:bg .
                \ ' gui='   . a:style . ' cterm=' . a:style
endfunction

let s:cyan            = "#56B6C2"
let s:dark_yellow     = "#D19A66"
let s:red             = "#e06c75"
let s:error_red       = "#f54c4c"
let s:green           = "#88B369"
let s:yellow          = "#E5C07B"
let s:blue            = "#61AFEF"
let s:purple          = "#B663CC"
let s:background      = "#282932"
let s:foreground      = "#b3b3c3"
let s:visual_bg       = "#353542"
let s:cursor_line_bg  = "#2e2e3a"
let s:dark_grey       = "#41414e"
let s:comment_grey    = "#636378"
let s:statusline_fill = "#383848"
let s:bright_bg       = "#505060"
let s:bright_fg       = "#E3E3E3"
let s:status_bg       = "#27272f"
let s:border_color    = "#565661"

call HL("Normal",                 s:foreground,   s:background,      "NONE")
call HL("Conceal",                s:foreground,   "NONE",            "NONE")
call HL("Cursor",                 s:background,   s:foreground,      "NONE")
call HL("CursorLine",             "NONE",         s:cursor_line_bg,  "NONE")
call HL("CursorColumn",           "NONE",         s:cursor_line_bg,  "NONE")
call HL("SignColumn",             "NONE",         "NONE",            "NONE")
call HL("FoldColumn",             "NONE",         "NONE",            "NONE")
call HL("VertSplit",              s:dark_grey,    s:background,      "NONE")
call HL("LineNr",                 s:dark_grey,    "NONE",            "NONE")
call HL("CursorLineNr",           "NONE",         s:cursor_line_bg,  "NONE")
call HL("Folded",                 s:comment_grey, "NONE",            "NONE")
call HL("IncSearch",              s:yellow,       s:statusline_fill, "NONE")
call HL("Search",                 "NONE",         s:statusline_fill, "NONE")
call HL("ModeMsg",                "NONE",         "NONE",            "NONE")
call HL("NonText",                "#3E4452",      "NONE",            "NONE")
call HL("Question",               s:purple,       "NONE",            "NONE")
call HL("SpecialKey",             "#3B4048",      "NONE",            "NONE")
call HL("StatusLine",             s:foreground,   s:status_bg,       "NONE")
call HL("StatusLineNC",           s:comment_grey, s:status_bg,       "NONE")
call HL("Title",                  s:green,        "NONE",            "BOLD")
call HL("Visual",                 "NONE",         s:visual_bg,       "NONE")
call HL("WarningMsg",             s:yellow,       "NONE",            "NONE")
call HL("Pmenu",                  "NONE",         s:statusline_fill, "NONE")
call HL("PmenuSel",               s:foreground,   s:bright_bg,       "NONE")
call HL("DiffDelete",             s:red,          s:background,      "NONE")
call HL("DiffAdd",                s:green,        s:background,      "NONE")
call HL("DiffChange",             s:yellow,       s:background,      "BOLD")
call HL("DiffText",               s:background,   s:foreground,      "NONE")
call HL("Underlined",             "NONE",         "NONE",            "UNDERLINE")
call HL("OperatorSandwichChange", "NONE",         "#3E4452",         "NONE")
call HL("Comment",                s:comment_grey, "NONE",            "ITALIC")
call HL("Exception",              s:cyan,         "NONE",            "NONE")
call HL("Constant",               s:cyan,         "NONE",            "NONE")
call HL("Float",                  s:dark_yellow,  "NONE",            "NONE")
call HL("Number",                 s:dark_yellow,  "NONE",            "NONE")
call HL("Boolean",                s:dark_yellow,  "NONE",            "NONE")
call HL("Identifier",             s:red,          "NONE",            "NONE")
call HL("SpellBad",               s:red,          "NONE",            "UNDERCURL")
call HL("Keyword",                s:red,          "NONE",            "NONE")
call HL("Error",                  s:red,          "NONE",            "NONE")
call HL("ErrorMsg",               s:red,          "NONE",            "NONE")
call HL("PmenuSbar",              "#00FF00",      "NONE",            "NONE")
call HL("String",                 s:green,        "NONE",            "NONE")
call HL("Character",              s:green,        "NONE",            "NONE")
call HL("PreProc",                s:yellow,       "NONE",            "NONE")
call HL("SpellCap",               s:yellow,       "NONE",            "UNDERCURL")
call HL("PreCondit",              s:yellow,       "NONE",            "NONE")
call HL("StorageClass",           s:yellow,       "NONE",            "NONE")
call HL("Structure",              s:yellow,       "NONE",            "NONE")
call HL("Type",                   s:yellow,       "NONE",            "NONE")
call HL("Special",                s:blue,         "NONE",            "NONE")
call HL("WildMenu",               s:background,   s:blue,            "NONE")
call HL("Include",                s:blue,         "NONE",            "NONE")
call HL("Function",               s:blue,         "NONE",            "NONE")
call HL("Todo",                   s:purple,       "NONE",            "NONE")
call HL("Repeat",                 s:purple,       "NONE",            "NONE")
call HL("Define",                 s:purple,       "NONE",            "NONE")
call HL("Macro",                  s:purple,       "NONE",            "NONE")
call HL("Statement",              s:purple,       "NONE",            "NONE")
call HL("Label",                  s:purple,       "NONE",            "NONE")
call HL("Operator",               s:purple,       "NONE",            "NONE")
call HL("MatchParen",             s:purple,       s:statusline_fill, "NONE")
call HL("TabLine",                "#BBBBBB",      s:statusline_fill, "NONE")
call HL("TabLineFill",            "NONE",         s:statusline_fill, "NONE")
call HL("TabLineSel",             s:bright_fg,    s:bright_bg,       "NONE")
call HL("CocErrorSign",           s:error_red,    "NONE",            "NONE")
call HL("Directory",              s:blue,         "NONE",            "NONE")

let g:terminal_ansi_colors = [
 \ s:comment_grey, s:red,    s:green, s:yellow,
 \ s:blue,         s:purple, s:cyan,  "#f1f1ef",
 \ s:comment_grey, s:red,    s:green, s:yellow,
 \ s:blue,         s:purple, s:cyan,  "#f1f1ef"
 \]

" hi default                CocErrorSign  ctermfg=Red   guifg=#E06C75
call HL("CocFadeout", s:comment_grey, "NONE", "NONE")
call HL("CocUnderline", s:error_red, "NONE", "NONE")
hi default CocWarningSign ctermfg=Brown guifg=#ff922b
au VimEnter * hi CocMenuSel guifg=NONE guibg=NONE cterm=NONE


function RemoveCursorlineInVisual()
    if mode() =~# '^[vV\x16]'
        set showcmd
        exe 'hi CursorLineNr guibg=' . s:background
    else
        set noshowcmd
        exe 'hi CursorLineNr guibg=' . s:cursor_line_bg
    endif
endfunction

au ModeChanged [vV\x16]*:* call RemoveCursorlineInVisual()
au ModeChanged *:[vV\x16]* call RemoveCursorlineInVisual()
au WinEnter,WinLeave *     call RemoveCursorlineInVisual()

" vim: nowrap

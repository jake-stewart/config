function! HL(name, fg, bg, style)
    exe 'hi ' . a:name .
                \ ' guifg=' . a:fg    . ' guibg=' . a:bg .
                \ ' gui='   . a:style . ' cterm=' . a:style
endfunction

let s:cyan            = "#56B6C2"
let s:dark_yellow     = "#D19A66"
let s:red             = "#e06c75"
let s:warn_orange     = "#f5a34c"
let s:error_red       = "#f54c4c"
let s:green           = "#88B369"
let s:yellow          = "#E5C07B"
let s:blue            = "#61AFEF"
let s:purple          = "#B663CC"
let s:background      = "#26272F"
let s:foreground      = "#b3b3c3"
let s:visual_bg       = "#353641"
let s:cursor_line_bg  = "#2c2e38"
let s:dark_grey       = "#41424E"
let s:comment_grey    = "#636372"
let s:statusline_fill = "#33353f"
let s:bright_bg       = "#4a4d58"
let s:bright_fg       = "#E3E3E3"
let s:status_bg       = "#21222a"

let s:light_grey      = "#8f90b3"

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
call HL("Error",                  s:error_red,    "NONE",            "NONE")
call HL("ErrorMsg",               s:error_red,    "NONE",            "NONE")
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

call HL("TSAnnotation",         s:foreground,   "NONE", "NONE")
call HL("TSAttribute",          s:foreground,   "NONE", "NONE")
call HL("TSBoolean",            s:dark_yellow,  "NONE", "NONE")
call HL("TSCharacter",          s:dark_yellow,  "NONE", "NONE")
call HL("TSComment",            s:comment_grey, "NONE", "italic")
call HL("TSConditional",        s:purple,       "NONE", "NONE")
call HL("TSConstant",           s:cyan,         "NONE", "NONE")
call HL("TSConstBuiltin",       s:cyan,         "NONE", "NONE")
call HL("TSConstMacro",         s:dark_yellow,  "NONE", "NONE")
call HL("TSConstructor",        s:yellow,       "NONE", "NONE")
call HL("TSError",              s:foreground,   "NONE", "NONE")
call HL("TSException",          s:purple,       "NONE", "NONE")
call HL("TSField",              s:foreground,   "NONE", "NONE")
call HL("TSFloat",              s:dark_yellow,  "NONE", "NONE")
call HL("TSFunction",           s:blue,         "NONE", "NONE")
call HL("TSFuncBuiltin",        s:blue,         "NONE", "NONE")
call HL("TSFuncMacro",          s:blue,         "NONE", "NONE")
call HL("TSInclude",            s:purple,       "NONE", "NONE")
call HL("TSKeyword",            s:purple,       "NONE", "NONE")
call HL("TSKeywordFunction",    s:purple,       "NONE", "NONE")
call HL("TSKeywordOperator",    s:purple,       "NONE", "NONE")
call HL("TSLabel",              s:red,          "NONE", "NONE")
call HL("TSMethod",             s:blue,         "NONE", "NONE")
call HL("TSNamespace",          s:yellow,       "NONE", "NONE")
call HL("TSNone",               s:foreground,   "NONE", "NONE")
call HL("TSNumber",             s:dark_yellow,  "NONE", "NONE")
call HL("TSOperator",           s:foreground,   "NONE", "NONE")
call HL("TSParameter",          s:foreground,   "NONE", "NONE")
call HL("TSParameterReference", s:foreground,   "NONE", "NONE")
call HL("TSProperty",           s:cyan,         "NONE", "NONE")
call HL("TSPunctDelimiter",     s:foreground,   "NONE", "NONE")
call HL("TSPunctBracket",       s:foreground,   "NONE", "NONE")
call HL("TSPunctSpecial",       s:red,          "NONE", "NONE")
call HL("TSRepeat",             s:purple,       "NONE", "NONE")
call HL("TSString",             s:green,        "NONE", "NONE")
call HL("TSStringRegex",        s:dark_yellow,  "NONE", "NONE")
call HL("TSStringEscape",       s:red,          "NONE", "NONE")
call HL("TSSymbol",             s:cyan,         "NONE", "NONE")
call HL("TSTag",                s:red,          "NONE", "NONE")
call HL("TSTagDelimiter",       s:red,          "NONE", "NONE")
call HL("TSText",               s:foreground,   "NONE", "NONE")
call HL("TSStrong",             s:foreground,   "NONE", 'bold')
call HL("TSEmphasis",           s:foreground,   "NONE", 'italic')
call HL("TSUnderline",          s:foreground,   "NONE", 'underline')
call HL("TSStrike",             s:foreground,   "NONE", 'strikethrough')
call HL("TSTitle",              s:dark_yellow,  'NONE', 'bold')
call HL("TSLiteral",            s:green,        "NONE", "NONE")
call HL("TSURI",                s:cyan,         "NONE", 'underline')
call HL("TSMath",               s:foreground,   "NONE", "NONE")
call HL("TSTextReference",      s:blue,         "NONE", "NONE")
call HL("TSEnviroment",         s:foreground,   "NONE", "NONE")
call HL("TSEnviromentName",     s:foreground,   "NONE", "NONE")
call HL("TSNote",               s:foreground,   "NONE", "NONE")
call HL("TSWarning",            s:foreground,   "NONE", "NONE")
call HL("TSDanger",             s:foreground,   "NONE", "NONE")
call HL("TSType",               s:red,   "NONE", "NONE")
call HL("TSTypeBuiltin",        s:dark_yellow,  "NONE", "NONE")
call HL("TSVariable",           s:foreground,   "NONE", "NONE")
call HL("TSVariableBuiltin",    s:red,          "NONE", "NONE")


call HL("DiagnosticError", s:error_red, "NONE", "underline")
call HL("DiagnosticHint", s:comment_grey, "NONE", "underline")
call HL("DiagnosticInfo", s:comment_grey, "NONE", "underline")
call HL("DiagnosticWarn", s:warn_orange, "NONE", "underline")
call HL("DiagnosticUnderlineError", s:error_red, "NONE", "underline")
call HL("DiagnosticUnderlineHint", s:comment_grey, "NONE", "underline")
call HL("DiagnosticUnderlineInfo", s:comment_grey, "NONE", "underline")
call HL("DiagnosticUnderlineWarn", s:warn_orange, "NONE", "underline")

call HL("Border", s:dark_grey, "NONE", "NONE")

hi default link BqfPreviewBorder Border
hi default link BqfPreviewFloat Normal
hi default link BqfPreviewCursor Cursor
hi default link BqfPreviewRange IncSearch

let g:fzf_colors = { 'border':  ['fg', 'Border'] }

call HL("LeapMatch",          "NONE", s:background, "NONE")
call HL("LeapLabelPrimary",   "NONE", s:statusline_fill, "NONE")
call HL("LeapLabelSecondary", "NONE", s:background, "NONE")
call HL("LeapBackdrop",       "NONE", s:background, "NONE")

sign define DiagnosticSignError text=
sign define DiagnosticSignWarn  text=
" sign define DiagnosticSignInfo  text= texthl=TextInfo  linehl= numhl=
" sign define DiagnosticSignHint  text= texthl=TextHint  linehl= numhl=

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

"
" __     ___              ____      _                
" \ \   / (_)_ __ ___    / ___|___ | | ___  _ __ ___ 
"  \ \ / /| | '_ ` _ \  | |   / _ \| |/ _ \| '__/ __|
"   \ V / | | | | | | | | |__| (_) | | (_) | |  \__ \
"    \_/  |_|_| |_| |_|  \____\___/|_|\___/|_|  |___/
"

" COLOR PALETTE {{{

let s:cyan        = "#56B6C2"
let s:dark_yellow = "#D19A66"
let s:red         = "#e06c75"
let s:warn_orange = "#f5a34c"
let s:error_red   = "#f54c4c"
let s:green       = "#88B369"
let s:yellow      = "#E5C07B"
let s:blue        = "#61AFEF"
let s:purple      = "#B663CC"
let s:bg          = "#252932"
let s:fg          = "#b3b3c3"
let s:visual_bg   = "#323644"
let s:cul_bg      = "#2a2e3a"
let s:dark_grey   = "#404350"
let s:comment_fg  = "#5d6070"
let s:bright_bg   = "#313440"
let s:x_bright_bg = "#4a4d58"
let s:bright_fg   = "#E3E3E3"
let s:status_bg   = "#21222a"
let s:light_grey  = "#8f90b3"
let s:white       = "#f1f1ef"
let s:unknown     = "#ff00ff"

" }}}
" HL FUNCITION {{{

function! HL(name, fg, bg, style)
    exe 'hi ' . a:name .
                \ ' guifg=' . a:fg    . ' guibg=' . a:bg .
                \ ' gui='   . a:style . ' cterm=' . a:style
endfunction

" }}}
" HL DEFINITION {{{

call HL("Normal",                   s:fg,          s:bg,          "NONE")
call HL("Conceal",                  s:fg,          "NONE",        "NONE")
call HL("Cursor",                   s:bg,          s:fg,          "NONE")
call HL("CursorLine",               "NONE",        s:cul_bg,      "NONE")
call HL("CursorColumn",             "NONE",        s:cul_bg,      "NONE")
call HL("SignColumn",               "NONE",        "NONE",        "NONE")
call HL("FoldColumn",               "NONE",        "NONE",        "NONE")
call HL("VertSplit",                s:dark_grey,   "NONE",        "NONE")
call HL("LineNr",                   s:dark_grey,   "NONE",        "NONE")
call HL("CursorLineNr",             "NONE",        s:cul_bg,      "NONE")
call HL("Folded",                   s:comment_fg,  "NONE",        "NONE")
call HL("IncSearch",                s:yellow,      s:bright_bg,   "NONE")
call HL("Search",                   "NONE",        s:bright_bg,   "NONE")
call HL("ModeMsg",                  "NONE",        "NONE",        "NONE")
call HL("NonText",                  s:dark_grey,   "NONE",        "NONE")
call HL("Question",                 s:purple,      "NONE",        "NONE")
call HL("SpecialKey",               s:unknown,     "NONE",        "NONE")
call HL("StatusLine",               s:fg,          s:bright_bg,   "NONE")
call HL("StatusLineNC",             s:comment_fg,  s:bright_bg,   "NONE")
call HL("Title",                    s:green,       "NONE",        "BOLD")
call HL("Visual",                   "NONE",        s:visual_bg,   "NONE")
call HL("WarningMsg",               s:yellow,      "NONE",        "NONE")
call HL("Pmenu",                    "NONE",        s:bright_bg,   "NONE")
call HL("PmenuSel",                 s:fg,          s:x_bright_bg, "NONE")
call HL("PmenuThumb",               s:fg,          s:comment_fg,  "NONE")
call HL("PmenuSbar",                "NONE",        s:bright_bg,   "NONE")
call HL("CocMenu",                  s:fg,          "NONE",        "NONE")
call HL("CocMenuSel",               s:fg,          s:x_bright_bg, "NONE")
call HL("CocFadeout",               s:comment_fg,  "NONE",        "NONE")
call HL("CocWarningSign",           s:warn_orange, "NONE",        "NONE")
call HL("DiffDelete",               s:red,         "NONE",        "NONE")
call HL("DiffAdd",                  s:green,       "NONE",        "NONE")
call HL("DiffChange",               s:yellow,      "NONE",        "BOLD")
call HL("DiffText",                 s:bg,          s:fg,          "NONE")
call HL("Underlined",               "NONE",        "NONE",        "UNDERLINE")
call HL("OperatorSandwichChange",   "NONE",        s:unknown,     "NONE")
call HL("Comment",                  s:comment_fg,  "NONE",        "ITALIC")
call HL("Exception",                s:cyan,        "NONE",        "NONE")
call HL("Constant",                 s:cyan,        "NONE",        "NONE")
call HL("Float",                    s:dark_yellow, "NONE",        "NONE")
call HL("Number",                   s:dark_yellow, "NONE",        "NONE")
call HL("Boolean",                  s:dark_yellow, "NONE",        "NONE")
call HL("Identifier",               s:red,         "NONE",        "NONE")
call HL("Keyword",                  s:red,         "NONE",        "NONE")
call HL("Error",                    s:error_red,   "NONE",        "NONE")
call HL("ErrorMsg",                 s:error_red,   "NONE",        "NONE")
call HL("String",                   s:green,       "NONE",        "NONE")
call HL("Character",                s:green,       "NONE",        "NONE")
call HL("PreProc",                  s:yellow,      "NONE",        "NONE")
call HL("PreCondit",                s:yellow,      "NONE",        "NONE")
call HL("StorageClass",             s:yellow,      "NONE",        "NONE")
call HL("Structure",                s:yellow,      "NONE",        "NONE")
call HL("Type",                     s:yellow,      "NONE",        "NONE")
call HL("Special",                  s:blue,        "NONE",        "NONE")
call HL("WildMenu",                 s:bg,          s:blue,        "NONE")
call HL("Include",                  s:blue,        "NONE",        "NONE")
call HL("Function",                 s:blue,        "NONE",        "NONE")
call HL("Todo",                     s:purple,      "NONE",        "NONE")
call HL("Repeat",                   s:purple,      "NONE",        "NONE")
call HL("Define",                   s:purple,      "NONE",        "NONE")
call HL("Macro",                    s:purple,      "NONE",        "NONE")
call HL("Statement",                s:purple,      "NONE",        "NONE")
call HL("Label",                    s:purple,      "NONE",        "NONE")
call HL("Operator",                 s:purple,      "NONE",        "NONE")
call HL("MatchParen",               s:purple,      s:bright_bg,   "NONE")
call HL("TabLine",                  s:fg,          s:bright_bg,   "NONE")
call HL("TabLineFill",              "NONE",        s:bright_bg,   "NONE")
call HL("TabLineSel",               s:bright_fg,   s:bright_bg,   "NONE")
call HL("Directory",                s:blue,        "NONE",        "NONE")
call HL("TSAnnotation",             s:fg,          "NONE",        "NONE")
call HL("TSAttribute",              s:fg,          "NONE",        "NONE")
call HL("TSBoolean",                s:dark_yellow, "NONE",        "NONE")
call HL("TSCharacter",              s:dark_yellow, "NONE",        "NONE")
call HL("TSComment",                s:comment_fg,  "NONE",        "italic")
call HL("TSConditional",            s:purple,      "NONE",        "NONE")
call HL("TSConstant",               s:cyan,        "NONE",        "NONE")
call HL("TSConstBuiltin",           s:cyan,        "NONE",        "NONE")
call HL("TSConstMacro",             s:dark_yellow, "NONE",        "NONE")
call HL("TSConstructor",            s:yellow,      "NONE",        "NONE")
call HL("TSError",                  s:fg,          "NONE",        "NONE")
call HL("TSException",              s:purple,      "NONE",        "NONE")
call HL("TSField",                  s:fg,          "NONE",        "NONE")
call HL("TSFloat",                  s:dark_yellow, "NONE",        "NONE")
call HL("TSFunction",               s:blue,        "NONE",        "NONE")
call HL("TSFuncBuiltin",            s:blue,        "NONE",        "NONE")
call HL("TSFuncMacro",              s:blue,        "NONE",        "NONE")
call HL("TSInclude",                s:purple,      "NONE",        "NONE")
call HL("TSKeyword",                s:purple,      "NONE",        "NONE")
call HL("TSKeywordFunction",        s:purple,      "NONE",        "NONE")
call HL("TSKeywordOperator",        s:purple,      "NONE",        "NONE")
call HL("TSLabel",                  s:red,         "NONE",        "NONE")
call HL("TSMethod",                 s:blue,        "NONE",        "NONE")
call HL("TSNamespace",              s:yellow,      "NONE",        "NONE")
call HL("TSNone",                   s:fg,          "NONE",        "NONE")
call HL("TSNumber",                 s:dark_yellow, "NONE",        "NONE")
call HL("TSOperator",               s:fg,          "NONE",        "NONE")
call HL("TSParameter",              s:fg,          "NONE",        "NONE")
call HL("TSParameterReference",     s:fg,          "NONE",        "NONE")
call HL("TSProperty",               s:cyan,        "NONE",        "NONE")
call HL("TSPunctDelimiter",         s:fg,          "NONE",        "NONE")
call HL("TSPunctBracket",           s:fg,          "NONE",        "NONE")
call HL("TSPunctSpecial",           s:red,         "NONE",        "NONE")
call HL("TSRepeat",                 s:purple,      "NONE",        "NONE")
call HL("TSString",                 s:green,       "NONE",        "NONE")
call HL("TSStringRegex",            s:dark_yellow, "NONE",        "NONE")
call HL("TSStringEscape",           s:red,         "NONE",        "NONE")
call HL("TSSymbol",                 s:cyan,        "NONE",        "NONE")
call HL("TSTag",                    s:red,         "NONE",        "NONE")
call HL("TSTagDelimiter",           s:red,         "NONE",        "NONE")
call HL("TSText",                   s:fg,          "NONE",        "NONE")
call HL("TSStrong",                 s:fg,          "NONE",        'bold')
call HL("TSEmphasis",               s:fg,          "NONE",        'italic')
call HL("TSUnderline",              s:fg,          "NONE",        'underline')
call HL("TSStrike",                 s:fg,          "NONE",        'strikethrough')
call HL("TSTitle",                  s:dark_yellow, 'NONE',        'bold')
call HL("TSLiteral",                s:green,       "NONE",        "NONE")
call HL("TSURI",                    s:cyan,        "NONE",        'underline')
call HL("TSMath",                   s:fg,          "NONE",        "NONE")
call HL("TSTextReference",          s:blue,        "NONE",        "NONE")
call HL("TSEnviroment",             s:fg,          "NONE",        "NONE")
call HL("TSEnviromentName",         s:fg,          "NONE",        "NONE")
call HL("TSNote",                   s:fg,          "NONE",        "NONE")
call HL("TSWarning",                s:fg,          "NONE",        "NONE")
call HL("TSDanger",                 s:fg,          "NONE",        "NONE")
call HL("TSType",                   s:red,         "NONE",        "NONE")
call HL("TSTypeBuiltin",            s:dark_yellow, "NONE",        "NONE")
call HL("TSVariable",               s:fg,          "NONE",        "NONE")
call HL("TSVariableBuiltin",        s:red,         "NONE",        "NONE")
call HL("DiagnosticError",          s:error_red,   "NONE",        "NONE")
call HL("DiagnosticHint",           s:comment_fg,  "NONE",        "NONE")
call HL("DiagnosticInfo",           s:comment_fg,  "NONE",        "NONE")
call HL("DiagnosticWarn",           s:warn_orange, "NONE",        "NONE")
call HL("DiagnosticUnderlineError", s:error_red,   "NONE",        "underline")
call HL("DiagnosticUnderlineHint",  s:comment_fg,  "NONE",        "underline")
call HL("DiagnosticUnderlineInfo",  s:comment_fg,  "NONE",        "underline")
call HL("DiagnosticUnderlineWarn",  s:warn_orange, "NONE",        "underline")
call HL("Border",                   s:dark_grey,   "NONE",        "NONE")

" exe 'hi SpellCap gui=UNDERCURL guisp=' . s:yellow
" exe 'hi SpellBad gui=UNDERCURL guisp=' . s:red
exe 'hi SpellCap gui=UNDERCURL guifg=' . s:yellow
exe 'hi SpellBad gui=UNDERCURL guifg=' . s:red

hi default link BqfPreviewBorder Border
hi default link BqfPreviewFloat  Normal
hi default link BqfPreviewCursor Cursor
hi default link BqfPreviewRange  IncSearch

" }}}
" TERMINAL HIGHLIGHTING {{{

let g:terminal_color_0  = s:comment_fg
let g:terminal_color_1  = s:red
let g:terminal_color_2  = s:green
let g:terminal_color_3  = s:yellow
let g:terminal_color_4  = s:blue
let g:terminal_color_5  = s:purple
let g:terminal_color_6  = s:cyan
let g:terminal_color_7  = s:white
let g:terminal_color_8  = s:comment_fg
let g:terminal_color_9  = s:red
let g:terminal_color_10 = s:green
let g:terminal_color_11 = s:yellow
let g:terminal_color_12 = s:blue
let g:terminal_color_13 = s:purple
let g:terminal_color_14 = s:cyan
let g:terminal_color_15 = s:white

" }}}
" VISUAL CURSORLINE {{{

" in vim, the cursorline disappears when in visual mdoe
" however, the cursorline in the number column remains
" this function + autocommands removes cusorline from
" the number column when in visual mode

function RemoveCursorlineInVisual()
    if mode() =~# '^[vV\x16]'
        set showcmd
        exe 'hi CursorLineNr guibg=' . s:bg
    else
        set noshowcmd
        exe 'hi CursorLineNr guibg=' . s:cul_bg
    endif
endfunction

au ModeChanged [vV\x16]*:* call RemoveCursorlineInVisual()
au ModeChanged *:[vV\x16]* call RemoveCursorlineInVisual()
au WinEnter,WinLeave *     call RemoveCursorlineInVisual()

" }}}

" vim:nowrap:foldmethod=marker

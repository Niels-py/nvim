local C = {
    rosewater = "#f5e0dc",
    flamingo = "#f2cdcd",
    pink = "#f5c2e7",
    mauve = "#cba6f7",
    red = "#f38ba8",
    maroon = "#eba0ac",
    peach = "#fab387",
    yellow = "#f9e2af",
    green = "#a6e3a1",
    teal = "#94e2d5",
    sky = "#89dceb",
    sapphire = "#74c7ec",
    blue = "#89b4fa",
    lavender = "#b4befe",
    text = "#cdd6f4",
    subtext1 = "#bac2de",
    subtext0 = "#a6adc8",
    overlay2 = "#9399b2",
    overlay1 = "#7f849c",
    overlay0 = "#6c7086",
    surface2 = "#585b70",
    surface1 = "#45475a",
    surface0 = "#313244",
    base = "#1e1e2e",
    mantle = "#181825",
    crust = "#11111b",
}

local function hl(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

hl("Normal", { fg = C.text, bg = C.base })
hl("Visual", { bg = C.surface1, bold = true })
hl("Conceal", { fg = C.overlay1 })
hl("ColorColumn", { bg = C.surface0 })
hl("Cursor", { fg = C.base, bg = C.rosewater })
hl("lCursor", { fg = C.base, bg = C.rosewater })
hl("CursorIM", { fg = C.base, bg = C.rosewater })
hl("CursorColumn", { bg = C.mantle })
hl("CursorLine", { bg = C.surface0 })
hl("Directory", { fg = C.blue })
hl("DiffAdd", { fg = C.base, bg = C.green })
hl("DiffChange", { fg = C.base, bg = C.yellow })
hl("DiffDelete", { fg = C.base, bg = C.red })
hl("DiffText", { fg = C.base, bg = C.blue })
hl("EndOfBuffer", {})
hl("ErrorMsg", { fg = C.red, bold = true, italic = true })
hl("VertSplit", { fg = C.crust })
hl("Folded", { fg = C.blue, bg = C.surface1 })
hl("FoldColumn", { fg = C.overlay0, bg = C.base })
hl("SignColumn", { fg = C.surface1, bg = C.base })
hl("IncSearch", { fg = C.surface1, bg = C.pink })
hl("CurSearch", { fg = C.surface1, bg = C.mauve })
hl("CursorLineNR", { fg = C.lavender })
hl("LineNr", { fg = C.surface1 })
hl("MatchParen", { fg = C.peach, bold = true })
hl("ModeMsg", { fg = C.text, bold = true })
hl("MoreMsg", { fg = C.blue })
hl("NonText", { fg = C.overlay0 })
hl("Pmenu", { fg = C.overlay2, bg = C.surface0 })
hl("PmenuSel", { fg = C.text, bg = C.surface1, bold = true })
hl("PmenuSbar", { bg = C.surface1 })
hl("PmenuThumb", { bg = C.overlay0 })
hl("Question", { fg = C.blue })
hl("QuickFixLine", { bg = C.surface1, bold = true })
hl("Search", { fg = C.pink, bg = C.surface1, bold = true })
hl("SpecialKey", { fg = C.subtext0 })
hl("SpellBad", { fg = C.base, bg = C.red })
hl("SpellCap", { fg = C.base, bg = C.yellow })
hl("SpellLocal", { fg = C.base, bg = C.blue })
hl("SpellRare", { fg = C.base, bg = C.green })
hl("StatusLine", { fg = C.text, bg = C.mantle })
hl("StatusLineNC", { fg = C.surface1, bg = C.mantle })
hl("StatusLineTerm", { fg = C.text, bg = C.mantle })
hl("StatusLineTermNC", { fg = C.surface1, bg = C.mantle })
hl("TabLine", { fg = C.surface1, bg = C.mantle })
hl("TabLineFill", { bg = C.mantle })
hl("TabLineSel", { fg = C.green, bg = C.surface1 })
hl("Title", { fg = C.blue, bold = true })
hl("VisualNOS", { bg = C.surface1, bold = true })
hl("WarningMsg", { fg = C.yellow })
hl("WildMenu", { bg = C.overlay0 })
hl("Comment", { fg = C.overlay0, italic = true })
hl("Constant", { fg = C.peach, bold = true })
hl("Identifier", { fg = C.flamingo })
hl("Statement", { fg = C.mauve })
hl("PreProc", { fg = C.pink })
hl("Type", { fg = C.blue })
hl("Special", { fg = C.pink })
hl("Underlined", { fg = C.text, bg = C.base, underline = true })
hl("Error", { fg = C.red, underline = true })
hl("Todo", { fg = C.base, bg = C.flamingo, bold = true })

hl("String", { fg = C.green, italic = true })
hl("Character", { fg = C.teal, bold = true })
hl("Number", { fg = C.peach, bold = true })
hl("Boolean", { fg = C.peach, bold = true })
hl("Float", { fg = C.peach })
hl("Function", { fg = C.blue, italic = true })
hl("Conditional", { fg = C.red, bold = true, italic = true })
hl("Repeat", { fg = C.red, bold = true })
hl("Label", { fg = C.peach, bold = true })
hl("Operator", { fg = C.sky })
hl("Keyword", { fg = C.pink })
hl("Include", { fg = C.pink })
hl("StorageClass", { fg = C.yellow })
hl("Structure", { fg = C.yellow })
hl("Typedef", { fg = C.yellow })
hl("debugPC", { bg = C.crust })
hl("debugBreakpoint", { fg = C.overlay0, bg = C.base })


-- PLUGINS

-- blink.indent
hl("BlinkIndent", { fg = C.surface0 })
hl("BlinkIndentScope", { fg = C.overlay2 })

-- blink.cmp (icons)
hl("BlinkCmpKindText", { fg = C.green })
hl("BlinkCmpKindMethod", { fg = C.blue })
hl("BlinkCmpKindFunction", { fg = C.blue })
hl("BlinkCmpKindConstructor", { fg = C.blue })
hl("BlinkCmpKindField", { fg = C.green })
hl("BlinkCmpKindVariable", { fg = C.flamingo })
hl("BlinkCmpKindClass", { fg = C.yellow })
hl("BlinkCmpKindInterface", { fg = C.yellow })
hl("BlinkCmpKindModule", { fg = C.blue })
hl("BlinkCmpKindProperty", { fg = C.blue })
hl("BlinkCmpKindUnit", { fg = C.green })
hl("BlinkCmpKindValue", { fg = C.peach })
hl("BlinkCmpKindEnum", { fg = C.yellow })
hl("BlinkCmpKindKeyword", { fg = C.mauve })
hl("BlinkCmpKindSnippet", { fg = C.flamingo })
hl("BlinkCmpKindColor", { fg = C.red })
hl("BlinkCmpKindFile", { fg = C.blue })
hl("BlinkCmpKindReference", { fg = C.red })
hl("BlinkCmpKindFolder", { fg = C.blue })
hl("BlinkCmpKindEnumMember", { fg = C.teal })
hl("BlinkCmpKindConstant", { fg = C.peach })
hl("BlinkCmpKindStruct", { fg = C.blue })
hl("BlinkCmpKindEvent", { fg = C.blue })
hl("BlinkCmpKindOperator", { fg = C.sky })
hl("BlinkCmpKindTypeParameter", { fg = C.maroon })
hl("BlinkCmpKindCopilot", { fg = C.teal })

-- mini diff

hl("MiniDiffSignAdd", { fg = C.green })
hl("MiniDiffSignChange", { fg = C.yellow })
hl("MiniDiffSignDelete", { fg = C.red })

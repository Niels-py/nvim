function _G.get_mode()
    local modes = {
        ["n"]   = "NORMAL",
        ["no"]  = "NORMAL",
        ["v"]   = "VISUAL",
        ["V"]   = "V-LINE",
        ["\22"] = "V-BLOCK",
        ["s"]   = "SELECT",
        ["S"]   = "S-LINE",
        ["\19"] = "S-BLOCK",
        ["i"]   = "INSERT",
        ["ic"]  = "INSERT",
        ["R"]   = "REPLACE",
        ["Rv"]  = "V-REPL",
        ["c"]   = "COMMAND",
        ["cv"]  = "VIM EX",
        ["ce"]  = "EX",
        ["r"]   = "PROMPT",
        ["rm"]  = "MOAR",
        ["r?"]  = "CONFIRM",
        ["!"]   = "SHELL",
        ["t"]   = "TERM",
    }
    return modes[vim.fn.mode()] or vim.fn.mode()
end

vim.opt.statusline =
    '%-11{[v:lua.get_mode()]} %t' ..
    '%= %Y [%3p%% %3l:%-2c]'

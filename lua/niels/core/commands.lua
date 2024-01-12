local run = {
    c = "cc -o %:p:r.o % && ./%:p:r.o",
    rust = "cargo run",
    go = "go run %",
    python = "python3 %"
}

vim.api.nvim_create_user_command("Run", function()
    local filetype = vim.bo.filetype

    for file, command in pairs(run) do
        if filetype == file then
            vim.cmd("sp")
            vim.cmd("term " .. command)
            vim.cmd("resize 20N")
            break
        end
    end
end, {})

vim.api.nvim_exec([[
    autocmd TermOpen * setlocal nonumber norelativenumber
]], false)

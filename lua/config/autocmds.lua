-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--
--
-- hack to get the cs templates without having the -32000 error
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*.cs",
    callback = function()
        -- only apply if the file is empty
        if vim.api.nvim_buf_line_count(0) > 1 then
            return
        end
        if vim.fn.getline(1) ~= "" then
            return
        end
        local full_path = vim.fn.expand("%:p")
        local actual_name =
            vim.fn.system("powershell -Command \"Get-Item '" .. full_path .. "' | Select-Object -ExpandProperty Name\"")
        actual_name = actual_name:gsub("\r\n", ""):gsub("\n", "")
        local filename = actual_name:gsub("%.cs$", "")
        local relative_path = vim.fn.expand("%:.:h")
        local namespace = relative_path:gsub("/", "."):gsub("\\", ".")
        if namespace == "." then
            namespace = "MyProject"
        end

        local lines = {
            "namespace " .. namespace .. ";",
            "",
            "public class " .. filename,
            "{",
            "",
            "}",
        }
        vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
        vim.cmd("write")
        vim.api.nvim_win_set_cursor(0, { 5, 4 })
    end,
})

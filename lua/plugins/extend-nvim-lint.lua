return {
    "mfussenegger/nvim-lint",
    opts = {
        linters_by_ft = {
            cs = {}, -- disable linting for C#, roslyn handles it
        },
    },
}

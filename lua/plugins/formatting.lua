return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            typescript = { "prettier" },
            typescriptreact = { "prettier" },
        },
        formatters = {
            prettier = {
                command = "prettier",
                args = { "--tab-width", "4", "--stdin-filepath", "$FILENAME" },
            },
        },
    },
}

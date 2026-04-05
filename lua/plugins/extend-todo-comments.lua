return {
    "folke/todo-comments.nvim",
    opts = {
        highlight = {
            pattern = [[.*<(KEYWORDS)\s*:?\s*]],
            keyword = "fg", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty
            after = "fg",
        },
        search = {
            pattern = [[\b(KEYWORDS)\b]],
        },
    },
}

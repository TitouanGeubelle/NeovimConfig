return {
    "akinsho/bufferline.nvim",
    opts = {
        options = {
            always_show_bufferline = true,
            numbers = "ordinal", -- shows position numbers on each buffer tab
        },
    },
    keys = {
        { "<leader>b1", "<cmd>BufferLineGoToBuffer 1<cr>", desc = "Go to buffer 1" },
        { "<leader>b2", "<cmd>BufferLineGoToBuffer 2<cr>", desc = "Go to buffer 2" },
        { "<leader>b3", "<cmd>BufferLineGoToBuffer 3<cr>", desc = "Go to buffer 3" },
        { "<leader>b4", "<cmd>BufferLineGoToBuffer 4<cr>", desc = "Go to buffer 4" },
        { "<leader>b5", "<cmd>BufferLineGoToBuffer 5<cr>", desc = "Go to buffer 5" },
        { "<leader>b6", "<cmd>BufferLineGoToBuffer 6<cr>", desc = "Go to buffer 6" },
        { "<leader>b7", "<cmd>BufferLineGoToBuffer 7<cr>", desc = "Go to buffer 7" },
        { "<leader>b8", "<cmd>BufferLineGoToBuffer 8<cr>", desc = "Go to buffer 8" },
        { "<leader>b9", "<cmd>BufferLineGoToBuffer 9<cr>", desc = "Go to buffer 9" },
        { "<leader>bl", "<cmd>BufferLineCycleNext<cr>", desc = "Go to right buffer" },
        { "<leader>bh", "<cmd>BufferLineCyclePrev<cr>", desc = "Go to left buffer" },
    },
}

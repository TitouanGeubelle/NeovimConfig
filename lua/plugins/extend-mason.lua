return {
    "mason-org/mason.nvim",
    opts = {
        registries = {
            "github:Crashdummyy/mason-registry", -- this contains the register for Roslyn
            "github:mason-org/mason-registry",
        },
        automatic_enable = {
            exclude = { "roslyn" },
        },
    },
}

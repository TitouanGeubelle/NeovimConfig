--
return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio", -- required by nvim-dap-ui
        "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        -- Point to vscode-js-debug
        local js_debug_path = vim.fn.expand("D:/dev/NvimDAPs/js-debug/src/dapDebugServer.js")

        -- Setup the adapter
        dap.adapters["pwa-node"] = {
            type = "server",
            host = "localhost",
            port = "${port}",
            executable = {
                command = "node",
                args = { js_debug_path, "${port}" },
            },
        }

        -- Alias "node" to "pwa-node"
        dap.adapters["node"] = function(cb, config)
            if config.type == "node" then
                config.type = "pwa-node"
            end
            local a = dap.adapters["pwa-node"]
            if type(a) == "function" then
                a(cb, config)
            else
                cb(a)
            end
        end

        -- Debug configurations for JS/TS
        local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }
        for _, ft in ipairs(js_filetypes) do
            dap.configurations[ft] = {
                -- Attach to running Node.js process
                {
                    type = "pwa-node",
                    request = "attach",
                    name = "Attach to Node.js",
                    port = 9230,
                    address = "localhost",
                    localRoot = vim.fn.getcwd(),
                    cwd = vim.fn.getcwd(),
                    sourceMaps = true,
                    resolveSourceMapLocations = {
                        "${workspaceFolder}/**",
                        "!**/node_modules/**",
                    },
                    skipFiles = { "<node_internals>/**", "**/node_modules/**" },
                    protocol = "inspector",
                },
                -- Debug Mocha tests
                {
                    type = "pwa-node",
                    request = "launch",
                    name = "Debug Mocha Tests",
                    program = "${workspaceFolder}/node_modules/mocha/bin/_mocha",
                    args = {
                        "--require",
                        "ts-node/register/transpile-only",
                        "--require",
                        "source-map-support/register",
                        "--reporter",
                        "spec",
                        "--colors",
                        "${workspaceFolder}/tests/unit/**/*.[tj]s",
                    },
                    cwd = vim.fn.getcwd(),
                    runtimeExecutable = "node",
                    internalConsoleOptions = "openOnSessionStart",
                    skipFiles = { "<node_internals>/**" },
                    sourceMaps = true,
                    protocol = "inspector",
                },
                -- Debug Jest tests
                {
                    type = "pwa-node",
                    request = "launch",
                    name = "Debug Jest Tests",
                    program = "${workspaceFolder}/node_modules/jest/bin/jest.js",
                    args = { "--runInBand", "--no-cache", "${relativeFile}" },
                    cwd = "${workspaceFolder}",
                    runtimeExecutable = "node",
                    console = "integratedTerminal",
                    internalConsoleOptions = "neverOpen",
                    sourceMaps = true,
                    skipFiles = { "<node_internals>/**" },
                },
            }
        end

        -- DAP UI setup
        dapui.setup({
            icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
            controls = {
                icons = {
                    pause = "⏸",
                    play = "▶",
                    step_into = "⏎",
                    step_over = "⏭",
                    step_out = "⏮",
                    step_back = "b",
                    run_last = "▶▶",
                    terminate = "⏹",
                    disconnect = "⏏",
                },
            },
        })

        -- Auto-open/close UI
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({})
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close({})
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close({})
        end
        dap.listeners.before.disconnect["dapui_config"] = function()
            dapui.close({})
        end

        -- Virtual text
        require("nvim-dap-virtual-text").setup({})

-- Keymaps
-- stylua: ignore start
vim.keymap.set("n", "<leader>db", require("dap").toggle_breakpoint, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dB", function() require("dap").list_breakpoints(); vim.cmd("copen") end, { desc = "List Breakpoints" })
vim.keymap.set("n", "<leader>dc", function() require("dap").continue() end, { desc = "Run/Continue" })
vim.keymap.set("n", "<leader>dC", function() require("dap").run_to_cursor() end, { desc = "Run to Cursor" })
vim.keymap.set("n", "<leader>dg", function() require("dap").goto_() end, { desc = "Go to Line (No Execute)" })
vim.keymap.set("n", "<leader>di", function() require("dap").step_into() end, { desc = "Step Into" })
vim.keymap.set("n", "<leader>dj", function() require("dap").down() end, { desc = "Down" })
vim.keymap.set("n", "<leader>dk", function() require("dap").up() end, { desc = "Up" })
vim.keymap.set("n", "<leader>dl", function() require("dap").run_last() end, { desc = "Run Last" })
vim.keymap.set("n", "<leader>do", function() require("dap").step_out() end, { desc = "Step Out" })
vim.keymap.set("n", "<leader>dO", function() require("dap").step_over() end, { desc = "Step Over" })
vim.keymap.set("n", "<leader>dP", function() require("dap").pause() end, { desc = "Pause" })
vim.keymap.set("n", "<leader>dr", function() require("dap").repl.toggle() end, { desc = "Toggle REPL" })
vim.keymap.set("n", "<leader>ds", function() require("dap").session() end, { desc = "Session" })
vim.keymap.set("n", "<leader>dt", function()
	require("dap").terminate()
	vim.defer_fn(function()
		require("dapui").close({})
	end, 100)
end, { desc = "Terminate" })
vim.keymap.set("n", "<leader>dw", function() require("dap.ui.widgets").hover() end, { desc = "DAP Widgets" })
vim.keymap.set("n", "<leader>du", function() require("dapui").toggle({}) end, { desc = "Dap UI" })
    end,
}
-- stylua: ignore end

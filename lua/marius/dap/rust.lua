local M = {}

function M.setup()
--    local dap_install = require "dap-install"
--    dap_install.config("codelldb", {})
--
--    local dap = require "dap"
--    local install_root_dir = vim.fn.stdpath "data" .. "/mason"
--    local extension_path = install_root_dir .. "/packages/codelldb/extension/"
--    local codelldb_path = extension_path .. "adapter/codelldb"
--
--    dap.adapters.codelldb = {
--        type = "server",
--        port = "${port}",
--        executable = {
--            command = codelldb_path,
--            args = { "--port", "${port}" },
--
--            -- On windows you may have to uncomment this:
--            -- detached = false,
--        },
--    }
--    dap.configurations.cpp = {
--        {
--            name = "Launch file",
--            type = "codelldb",
--            request = "launch",
--            program = function()
--                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "target/debug/guessing_game")
--            end,
--            cwd = "${workspaceFolder}",
--            stopOnEntry = true,
--        },
--    }
--
--    dap.configurations.c = dap.configurations.cpp
--    dap.configurations.rust = dap.configurations.cpp
--

local dap = require("dap")
dap.adapters.gdb = {
    type = "executable",
    command = "gdb",    
    args = { "--interpreter", "dap" }
}

print("Inside rust.lua with the adapter")

dap.configurations.cpp = {
    {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function()
            return vim.fn.input(vim.fn.getcwd() .. '/', 'target/debug/guessing_game')
        end,
        cwd = "${workspaceFolder}",
    },
}


dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
end

return M

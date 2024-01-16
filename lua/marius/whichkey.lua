local M = {}

local whichkey = require "which-key"
--local legendary = require "legendary"
local next = next

local conf = {
    window = {
        border = "single", -- none, single, double, shadow
        position = "bottom", -- bottom, top
    },
}
whichkey.setup(conf)

local opts = {
    mode = "n", -- Normal mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
}

local v_opts = {
    mode = "v", -- Visual mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
}

local function normal_keymap()
    local keymap = {
        ["w"] = { "<cmd>update!<CR>", "Save" },
        ["q"] = { "<cmd>lua require('utils').quit()<CR>", "Quit" },
        ["1"] = { "<Cmd>lua require('harpoon.term').gotoTerminal(1)<Cr>", "Terminal 1" },
        ["2"] = { "<Cmd>lua require('harpoon.term').gotoTerminal(2)<Cr>", "Terminal 2" },
        ["3"] = { "<Cmd>lua require('harpoon.term').sendCommand(1,1)<Cr>", "Command 1" },
        ["4"] = { "<Cmd>lua require('harpoon.term').sendCommand(1,2)<Cr>", "Command 2" },

        a = {
            name = "Attempt",
            n = { "<Cmd>lua require('attempt').new_select()<Cr>", "New Select" },
            i = { "<Cmd>lua require('attempt').new_input_ext()<Cr>", "New Input Extension" },
            r = { "<Cmd>lua require('attempt').run()<Cr>", "Run" },
            d = { "<Cmd>lua require('attempt').delete_buf()<Cr>", "Delete Buffer" },
            c = { "<Cmd>lua require('attempt').rename_buf()<Cr>", "Rename Buffer" },
            s = { "<Cmd>Telescope attempt<Cr>", "Search" },
        },

        b = {
            name = "Buffer",
            c = { "<Cmd>BDelete this<Cr>", "Close Buffer" },
            f = { "<Cmd>bdelete!<Cr>", "Force Close Buffer" },
            D = { "<Cmd>BWipeout other<Cr>", "Delete All Buffers" },
            b = { "<Cmd>BufferLinePick<Cr>", "Pick a Buffer" },
            p = { "<Cmd>BufferLinePickClose<Cr>", "Pick & Close a Buffer" },
            m = { "<Cmd>JABSOpen<Cr>", "Menu" },
        },

        c = {
            name = "Code",
            g = { "<cmd>Neogen func<Cr>", "Func Doc" },
            G = { "<cmd>Neogen class<Cr>", "Class Doc" },
            d = { "<cmd>DogeGenerate<Cr>", "Generate Doc" },
            o = { "<cmd>Telescope aerial<Cr>", "Outline" },
            T = { "<cmd>TodoTelescope<Cr>", "TODO" },
            x = {
                name = "Swap Next",
                f = "Function",
                p = "Parameter",
                c = "Class",
            },
            X = {
                name = "Swap Previous",
                f = "Function",
                p = "Parameter",
                c = "Class",
            },
            -- f = "Select Outer Function",
            -- F = "Select Outer Class",
        },

        d = {
            name = "DAP",
            a = { "<cmd>Telescope dap list_breakpoints<cr>",                                 "List breakpoints" },
            R = { "<cmd>lua require'dap'.run_to_cursor()<cr>",                               "Run to Cursor" },
            E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>",        "Evaluate Input" },
            C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
            U = { "<cmd>lua require'dapui'.toggle()<cr>",                                    "Toggle UI" },
            b = { "<cmd>lua require'dap'.step_back()<cr>",                                   "Step Back" },
            c = { "<cmd>lua require'dap'.continue()<cr>",                                    "Continue" },
            d = { "<cmd>lua require'dap'.disconnect()<cr>",                                  "Disconnect" },
            e = { "<cmd>lua require'dapui'.eval()<cr>",                                      "Evaluate" },
            f = { "<cmd>Telescope dap frames<cr>",                                           "List frames" },
            g = { "<cmd>lua require'dap'.session()<cr>",                                     "Get Session" },
            h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>",                            "Hover Variables" },
            l = { "<cmd>lua require'dap'.run_last()<cr>",                                    "Run last" },
            L = { "<cmd>Telescope dap commands<cr>",                                         "List commands" },
            n = { "<cmd>lua require('dap').clear_breakpoints()<cr>",                         "Clear breakpoints" },
            S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>",                           "Scopes" },
            i = { "<cmd>lua require'dap'.step_into()<cr>",                                   "Step Into" },
            o = { "<cmd>lua require'dap'.step_over()<cr>",                                   "Step Over" },
            p = { "<cmd>lua require'dap'.pause.toggle()<cr>",                                "Pause" },
            q = { "<cmd>lua require'dap'.close()<cr>",                                       "Quit" },
            r = { "<cmd>lua require'dap'.repl.toggle()<cr>",                                 "Open/Toggle Repl" },
            l = { "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>", "Set log point" },
            t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>",                           "Toggle Breakpoint" },
            x = { "<cmd>lua require'dap'.terminate()<cr>",                                   "Terminate" },
            u = { "<cmd>lua require'dap'.step_out()<cr>",                                    "Step Out" },
--            remap("n", "<leader>d?", function() local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes) end, bufopts, "Scopes")
            S = { function() local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes) end, "Scopes" },
        },

        -- Database
        D = {
            name = "Database",
            u = { "<Cmd>DBUIToggle<Cr>", "Toggle UI" },
            f = { "<Cmd>DBUIFindBuffer<Cr>", "Find buffer" },
            r = { "<Cmd>DBUIRenameBuffer<Cr>", "Rename buffer" },
            q = { "<Cmd>DBUILastQueryInfo<Cr>", "Last query info" },
        },

        f = {
            name = "Find",
            f = { "<cmd>lua require('utils.finder').find_files()<cr>", "Files" },
            d = { "<cmd>lua require('utils.finder').find_dotfiles()<cr>", "Dotfiles" },
            b = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "Buffers" },
            h = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", "Help" },
            m = { "<cmd>lua require('telescope.builtin').marks()<cr>", "Marks" },
            o = { "<cmd>lua require('telescope.builtin').oldfiles()<cr>", "Old Files" },
            g = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Live Grep" },
            c = { "<cmd>lua require('telescope.builtin').commands()<cr>", "Commands" },
            r = { "<cmd>lua require'telescope'.extensions.file_browser.file_browser()<cr>", "File Browser" },
            w = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", "Current Buffer" },
            e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
        },

        g = {
            name = "Git",
            b = { "<cmd>GitBlameToggle<CR>", "Blame" },
            c = { "<cmd>lua require('utils.term').git_commit_toggle()<CR>", "Conventional Commits" },
            p = { "<cmd>Git push<CR>", "Push" },
            s = { "<cmd>lua require('neogit').open()<CR>", "Status - Neogit" },
            S = { "<cmd>Git<CR>", "Status - Fugitive" },
            y = {
                "<cmd>lua require'gitlinker'.get_buf_range_url('n', {action_callback = require'gitlinker.actions'.open_in_browser})<cr>",
                "Link",
            },
            g = { "<cmd>lua require('telescope').extensions.gh.gist()<CR>", "Gist" },
            z = { "<cmd>lua require('utils.term').git_client_toggle()<CR>", "Git TUI" },
            h = { name = "Hunk" },
            t = { name = "Toggle" },
            x = { "<cmd>lua require('telescope.builtin').git_branches()<cr>", "Switch Branch" }
        },

        o = {
            name = "Overseer",
            C = { "<cmd>OverseerClose<cr>", "OverseerClose" },
            a = { "<cmd>OverseerTaskAction<cr>", "OverseerTaskAction" },
            b = { "<cmd>OverseerBuild<cr>", "OverseerBuild" },
            c = { "<cmd>OverseerRunCmd<cr>", "OverseerRunCmd" },
            d = { "<cmd>OverseerDeleteBundle<cr>", "OverseerDeleteBundle" },
            l = { "<cmd>OverseerLoadBundle<cr>", "OverseerLoadBundle" },
            o = { "<cmd>OverseerOpen!<cr>", "OverseerOpen" },
            q = { "<cmd>OverseerQuickAction<cr>", "OverseerQuickAction" },
            r = { "<cmd>OverseerRun<cr>", "OverseerRun" },
            s = { "<cmd>OverseerSaveBundle<cr>", "OverseerSaveBundle" },
            t = { "<cmd>OverseerToggle!<cr>", "OverseerToggle" },
        },

        r = {
            name = "Refactor",
            i = { [[<cmd>lua require('refactoring').refactor('Inline Variable')<cr>]], "Inline Variable" },
            b = { [[<cmd>lua require('refactoring').refactor('Exract Block')<cr>]], "Extract Block" },
            B = { [[<cmd>lua require('refactoring').refactor('Exract Block To File')<cr>]], "Extract Block to File" },
            P = {
                [[<cmd>lua require('refactoring').debug.printf({below = false})<cr>]],
                "Debug Print",
            },
            p = {
                [[<cmd>lua require('refactoring').debug.print_var({normal = true})<cr>]],
                "Debug Print Variable",
            },
            c = { [[<cmd>lua require('refactoring').debug.cleanup({})<cr>]], "Debug Cleanup" },
        },

        s = {
            name = "Search",
            o = { [[ <Esc><Cmd>lua require('spectre').open()<CR>]], "Open" },
            c = { [[ <Esc><Cmd>lua require('utils.cht').cht_input()<CR>]], "cht.sh" },
            r = { [[ <Esc><Cmd>lua require('utils.term').rust_book()<CR>]], "Rust Book" },
            s = { [[ <Esc><Cmd>lua require('utils.term').so()<CR>]], "Stack Overflow" },
            w = { [[ <Esc><Cmd>lua require("telescope").extensions.arecibo.websearch()<CR>]], "Web" },
        },

        t = {
            name = "Test",
            a = { "<cmd>lua require('neotest').run.attach()<cr>", "Attach" },
            f = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", "Run File" },
            F = { "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Debug File" },
            l = { "<cmd>lua require('neotest').run.run_last()<cr>", "Run Last" },
            L = { "<cmd>lua require('neotest').run.run_last({ strategy = 'dap' })<cr>", "Debug Last" },
            n = { "<cmd>lua require('neotest').run.run()<cr>", "Run Nearest" },
            N = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Debug Nearest" },
            o = { "<cmd>lua require('neotest').output.open({ enter = true })<cr>", "Output" },
            S = { "<cmd>lua require('neotest').run.stop()<cr>", "Stop" },
            s = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Summary" },
            p = { "<Plug>PlenaryTestFile", "PlenaryTestFile" },
            v = { "<cmd>TestVisit<cr>", "Visit" },
            x = { "<cmd>TestSuite<cr>", "Suite" },
            t = {
                name = "Test",
                l = { "<cmd>TestLast<cr>", "Run Last" },
                n = { "<cmd>TestNearest<cr>", "Run Nearest" },
            },
        },

        v = {
            name = "Vimspector",
            G = { "<cmd>lua require('config.vimspector').generate_debug_profile()<cr>", "Generate Debug Profile" },
            I = { "<cmd>VimspectorInstall<cr>", "Install" },
            U = { "<cmd>VimspectorUpdate<cr>", "Update" },
            R = { "<cmd>call vimspector#RunToCursor()<cr>", "Run to Cursor" },
            c = { "<cmd>call vimspector#Continue()<cr>", "Continue" },
            i = { "<cmd>call vimspector#StepInto()<cr>", "Step Into" },
            o = { "<cmd>call vimspector#StepOver()<cr>", "Step Over" },
            s = { "<cmd>call vimspector#Launch()<cr>", "Start" },
            t = { "<cmd>call vimspector#ToggleBreakpoint()<cr>", "Toggle Breakpoint" },
            u = { "<cmd>call vimspector#StepOut()<cr>", "Step Out" },
            S = { "<cmd>call vimspector#Stop()<cr>", "Stop" },
            r = { "<cmd>call vimspector#Restart()<cr>", "Restart" },
            x = { "<cmd>VimspectorReset<cr>", "Reset" },
            H = { "<cmd>lua require('config.vimspector').toggle_human_mode()<cr>", "Toggle HUMAN mode" },
        },

        x = {
            name = "External",
            d = { "<cmd>lua require('utils.term').docker_client_toggle()<CR>", "Docker" },
            t = { "<cmd>lua require('utils.term').docker_ctop_toggle()<CR>", "Docker - ctop" },
            y = { "<cmd>lua require('utils.term').docker_dockly_toggle()<CR>", "Docker - dockly" },
            p = { "<cmd>lua require('utils.term').project_info_toggle()<CR>", "Project Info" },
            s = { "<cmd>lua require('utils.term').system_info_toggle()<CR>", "System Info" },
            c = { "<cmd>lua require('utils.term').cht()<CR>", "Cheatsheet" },
            i = { "<cmd>lua require('utils.term').interactive_cheatsheet_toggle()<CR>", "Interactive Cheatsheet" },
        },

        z = {
            name = "System",
            -- c = { "<cmd>PackerCompile<cr>", "Compile" },
            c = { "<cmd>Telescope neoclip<cr>", "Clipboard" },
            d = { "<cmd>DiffviewOpen<cr>", "Diff View Open" },
            D = { "<cmd>DiffviewClose<cr>", "Diff View Close" },
            i = { "<cmd>PackerInstall<cr>", "Install" },
            m = { "<cmd>lua require('telescope').extensions.macroscope.default()<cr>", "Macros" },
            p = { "<cmd>PackerProfile<cr>", "Profile" },
            s = { "<cmd>PackerSync<cr>", "Sync" },
            S = { "<cmd>PackerStatus<cr>", "Status" },
            u = { "<cmd>PackerUpdate<cr>", "Update" },
            -- x = { "<cmd>cd %:p:h<cr>", "Change Directory" },
            -- x = { "<cmd>set autochdir<cr>", "Auto ChDir" },
            x = { "<cmd>Telescope cder<cr>", "Change Directory" },
            e = { "!!$SHELL<CR>", "Execute line" },
            W = { "<cmd>lua require('utils.session').toggle_session()<cr>", "Toggle Workspace Saving" },
            w = { "<cmd>lua require('utils.session').list_session()<cr>", "Restore Workspace" },
            z = { "<cmd>lua require'telescope'.extensions.zoxide.list{}<cr>", "Zoxide" },
        },

    }
    whichkey.register(keymap, opts)
end

local function visual_keymap()
    local keymap = {

        d = {
            e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
        },

        g = {
            name = "Git",
            y = {
                "<cmd>lua require'gitlinker'.get_buf_range_url('v', {action_callback = require'gitlinker.actions'.open_in_browser})<cr>",
                "Link",
            },
        },

        r = {
            name = "Refactor",
            f = { [[<cmd>lua require('refactoring').refactor('Extract Function')<cr>]], "Extract Function" },
            F = {
                [[ <cmd>lua require('refactoring').refactor('Extract Function to File')<cr>]],
                "Extract Function to File",
            },
            v = { [[<cmd>lua require('refactoring').refactor('Extract Variable')<cr>]], "Extract Variable" },
            i = { [[<cmd>lua require('refactoring').refactor('Inline Variable')<cr>]], "Inline Variable" },
            r = { [[<cmd>lua require('telescope').extensions.refactoring.refactors()<cr>]], "Refactor" },
            d = { [[<cmd>lua require('refactoring').debug.print_var({})<cr>]], "Debug Print Var" },
        },
    }

    whichkey.register(keymap, v_opts)
end

local function code_keymap()
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function()
            vim.schedule(CodeRunner)
        end,
    })

    function CodeRunner()
        local bufnr = vim.api.nvim_get_current_buf()
        local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
        local fname = vim.fn.expand "%:p:t"
        local keymap_c = {} -- normal key map
        local keymap_c_v = {} -- visual key map

        if ft == "python" then
            keymap_c = {
                name = "Code",
                -- r = { "<cmd>update<CR><cmd>exec '!python3' shellescape(@%, 1)<cr>", "Run" },
                -- r = { "<cmd>update<CR><cmd>TermExec cmd='python3 %'<cr>", "Run" },
                i = { "<cmd>cexpr system('refurb --quiet ' . shellescape(expand('%'))) | copen<cr>", "Inspect" },
                r = {
                    "<cmd>update<cr><cmd>lua require('utils.term').open_term([[python3 ]] .. vim.fn.shellescape(vim.fn.getreg('%'), 1), {direction = 'float'})<cr>",
                    "Run",
                },
                m = { "<cmd>TermExec cmd='nodemon -e py %'<cr>", "Monitor" },
            }
        elseif ft == "lua" then
            keymap_c = {
                name = "Code",
                r = { "<cmd>luafile %<cr>", "Run" },
            }
        elseif ft == "rust" then
            keymap_c = {
                name = "Code",
                r = { "<cmd>execute 'Cargo run' | startinsert<cr>", "Run" },
                D = { "<cmd>RustDebuggables<cr>", "Debuggables" },
                h = { "<cmd>RustHoverActions<cr>", "Hover Actions" },
                R = { "<cmd>RustRunnables<cr>", "Runnables" },
            }
        elseif ft == "go" then
            keymap_c = {
                name = "Code",
                r = { "<cmd>GoRun<cr>", "Run" },
            }
        elseif ft == "typescript" or ft == "typescriptreact" or ft == "javascript" or ft == "javascriptreact" then
            keymap_c = {
                name = "Code",
                o = { "<cmd>TypescriptOrganizeImports<cr>", "Organize Imports" },
                r = { "<cmd>TypescriptRenameFile<cr>", "Rename File" },
                i = { "<cmd>TypescriptAddMissingImports<cr>", "Import Missing" },
                F = { "<cmd>TypescriptFixAll<cr>", "Fix All" },
                u = { "<cmd>TypescriptRemoveUnused<cr>", "Remove Unused" },
                R = { "<cmd>lua require('config.test').javascript_runner()<cr>", "Choose Test Runner" },
                -- s = { "<cmd>2TermExec cmd='yarn start'<cr>", "Yarn Start" },
                -- t = { "<cmd>2TermExec cmd='yarn test'<cr>", "Yarn Test" },
            }
        elseif ft == "java" then
            whichkey.register({
                j = {
                    name = "Java",
                    c = { "<cmd>lua require('jdtls').extract_constant()<cr>",    "Extract Constant" },
                    o = { "<cmd>lua require('jdtls').organize_imports()<cr>",    "Organize Imports" },
                    r = { "<cmd>lua require('jdtls').test_nearest_method()<cr>", "Test Nearest Method" },
                    t = { "<cmd>lua require('jdtls').test_class()<cr>",          "Test Class" },
                    v = { "<cmd>lua require('jdtls').extract_variable()<cr>",    "Extract Variable" },
                }
            }, opts)

            whichkey.register({
                j = {
                    name = "Java",
                    v = { "<cmd>lua require('jdtls').extract_variable(true)<cr>", "Extract Variable" },
                    c = { "<cmd>lua require('jdtls').extract_constant(true)<cr>", "Extract Constant" },
                    m = { "<cmd>lua require('jdtls').extract_method(true)<cr>",   "Extract Method" },
                }
            }, v_opts)
        end

        if fname == "package.json" then
            keymap_c.v = { "<cmd>lua require('package-info').show()<cr>", "Show Version" }
            keymap_c.c = { "<cmd>lua require('package-info').change_version()<cr>", "Change Version" }
            -- keymap_c.s = { "<cmd>2TermExec cmd='yarn start'<cr>", "Yarn Start" }
            -- keymap_c.t = { "<cmd>2TermExec cmd='yarn test'<cr>", "Yarn Test" }
        end

        if fname == "Cargo.toml" then
            keymap_c.u = { "<cmd>lua require('crates').upgrade_all_crates()<cr>", "Upgrade All Crates" }
        end

        if next(keymap_c) ~= nil then
            local k = { c = keymap_c }
            local o = { mode = "n", silent = true, noremap = true, buffer = bufnr, prefix = "<leader>", nowait = true }
            whichkey.register(k, o)
        end

        if next(keymap_c_v) ~= nil then
            local k = { c = keymap_c_v }
            local o = { mode = "v", silent = true, noremap = true, buffer = bufnr, prefix = "<leader>", nowait = true }
            whichkey.register(k, o)
        end
    end
end

function M.setup()
    normal_keymap()
    visual_keymap()
    code_keymap()
end

return M


local jdtls = require('jdtls')

-- File types that signify a Java project's root directory. This will be
-- used by eclipse to determine what constitutes a workspace
local root_markers = {'gradlew', 'mvnw', '.git', "pom.xml", "build.gradle"}
local root_dir = require('jdtls.setup').find_root(root_markers)

-- eclipse.jdt.ls stores project specific data within a folder. If you are working
-- with multiple different projects, each project must use a dedicated data directory.
-- This variable is used to configure eclipse to use the directory name of the
-- current project found using the root_marker as the folder for project specific data.
local workspace_folder = "/home/mariussiminic/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
local remap = require("marius.util").remap

-- The on_attach function is used to set key maps after the language server
-- attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Regular Neovim LSP client keymappings
  local remap     = require("marius.util").remap
  local jdtls     = require('jdtls')
  local which_key = require('which-key');

  remap("v", "<leader>em", [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], bufopts, "Extract method")
  remap("n", "<C-o>",      jdtls.organize_imports, bufopts, "Organize imports")
  remap("n", "<leader>vc", jdtls.test_class, bufopts, "Test class (DAP)")
  remap("n", "<leader>vm", jdtls.test_nearest_method, bufopts, "Test method (DAP)")
  remap("n", "<leader>ev", jdtls.extract_variable, bufopts, "Extract variable")
  remap("n", "<leader>ec", jdtls.extract_constant, bufopts, "Extract constant")

  -- nvim-dap
  remap("n", "<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", bufopts, "Set breakpoint")
  remap("n", "<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", bufopts, "Set conditional breakpoint")
  remap("n", "<leader>bl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>", bufopts, "Set log point")
  remap("n", "<leader>br", "<cmd>lua require'dap'.clear_breakpoints()<cr>", bufopts, "Clear breakpoints")
  remap("n", "<leader>ba", "<cmd>Telescope dap list_breakpoints<cr>", bufopts, "List breakpoints")

  which_key.register({
      b = {
          name = "breakpoints",
      },
  }, { prefix = "<leader>" })

  remap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>",    bufopts, "Continue")
  remap("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>",   bufopts, "Step over")
  remap("n", "<leader>dk", "<cmd>lua require'dap'.step_into()<cr>",   bufopts, "Step into")
  remap("n", "<leader>do", "<cmd>lua require'dap'.step_out()<cr>",    bufopts, "Step out")
  remap("n", "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>",  bufopts, "Disconnect")
  remap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>",   bufopts, "Terminate")
  remap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", bufopts, "Open REPL")
  remap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>",    bufopts, "Run last")
  remap("n", "<leader>di", function() require"dap.ui.widgets".hover() end, bufopts, "Variables")
  remap("n", "<leader>d?", function() local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes) end, bufopts, "Scopes")
  remap("n", "<leader>df", "<cmd>Telescope dap frames<cr>",           bufopts, "List frames")
  remap("n", "<leader>dh", "<cmd>Telescope dap commands<cr>",         bufopts, "List commands")

  which_key.register({
      d = {
          name = "debug",
      },
  }, { prefix = "<leader>" })

  -- With `hotcodereplace = 'auto' the debug adapter will try to apply code changes
  -- you make during a debug session immediately.
  -- Remove the option if you do not want that.
  jdtls.setup_dap { hotcodereplace = 'auto' }
  jdtls.etup_dap_main_class_configs()
  jdtls.setup.add_commands()
  vim.lsp.codelens.refresh()

  -- Java extensions
end

local bundles = {
  vim.fn.glob('/home/mariussiminic/.local/share/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar', 1),
}

vim.list_extend(bundles, vim.split(vim.fn.glob("/home/mariussiminic/.local/share/vscode-java-test/server/*.jar", 1), "\n"))
local config = {
  flags = {
    debounce_text_changes = 80,
  },
  on_attach = on_attach,  -- We pass our on_attach keybindings to the configuration map
  init_options = {
      bundles = bundles
  },
  root_dir = root_dir, -- Set the root directory to our found root_marker
  -- Here you can configure eclipse.jdt.ls specific settings
  -- These are defined by the eclipse.jdt.ls project and will be passed to eclipse when starting.
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
        format = {
            settings = {
                -- Use Google Java style guidelines for formatting
                -- To use, make sure to download the file from https://github.com/google/styleguide/blob/gh-pages/eclipse-java-google-style.xml
                -- and place it in the ~/.local/share/eclipse directory
                url = "/.local/share/eclipse/eclipse-java-google-style.xml",
                profile = "GoogleStyle",
            },
        },
      signatureHelp = { enabled = true },
      contentProvider = { preferred = 'fernflower' },  -- Use fernflower to decompile library code
      -- Specify any completion options
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*"
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*", "sun.*",
        },
      },
      -- Specify any options for organizing imports
      sources = {
        organizeImports = {
          starThreshold = 9999;
          staticStarThreshold = 9999;
        },
      },
      -- How code generation should act
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
        },
        hashCodeEquals = {
          useJava7Objects = true,
        },
        useBlocks = true,
      },
      -- If you are developing in projects with different Java versions, you need
      -- to tell eclipse.jdt.ls to use the location of the JDK for your Java version
      -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
      -- And search for `interface RuntimeOption`
      -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
      configuration = {
        runtimes = {
          {
            name = "JavaSE-17",
            path = "/usr/lib/jvm/java-17-openjdk-17.0.8.0.7-1.fc38.x86_64",
          }
        }
      }
    }
  },
  -- cmd is the command that starts the language server. Whatever is placed
  -- here is what is passed to the command line to execute jdtls.
  -- Note that eclipse.jdt.ls must be started with a Java version of 17 or higher
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  -- for the full list of options
  --
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx4g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    -- If you use lombok, download the lombok jar and place it in ~/.local/share/eclipse
    -- '-javaagent:' .. . '/.local/share/eclipse/lombok.jar',

    -- The jar file is located where jdtls was installed. This will need to be updated
    -- to the location where you installed jdtls
    '-jar', vim.fn.glob('/home/mariussiminic/.local/share/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
    -- The configuration for jdtls is also placed where jdtls was installed. This will
    -- need to be updated depending on your environment
    '-configuration', '/home/mariussiminic/.local/share/jdtls/config_linux',

    -- Use the workspace_folder defined above to store data for this project
    '-data', workspace_folder,
  },
}




-- print(dump(config))
-- Finally, start jdtls. This will run the language server using the configuration we specified,
-- setup the keymappings, and attach the LSP client to the current buffer
jdtls.start_or_attach(config)


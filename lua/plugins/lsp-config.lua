return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
    config = function()
      require("mason-lspconfig").setup({
        automatic_enable = false,
        ensure_installed = {
          "astro",
          "cssls",
          "html",
          "intelephense",
          "lua_ls",
          "stylelint_lsp",
          "tailwindcss",
          "ts_ls",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      -- Astro JS
      -- Requires `npm install -g @astrojs/language-server`
      require("lspconfig").astro.setup({
        capabilities = capabilities,
        on_attach = require("mason-lspconfig").on_attach,
        filetypes = { "astro" },
        -- IMPORTANT: Point to mason package for typescript to resolve error.
        init_options = {
          typescript = {
            tsdk = vim.fn.stdpath("data") .. "/mason/packages/typescript-language-server/node_modules/typescript/lib",
          },
        },
      })

      -- CSS
      -- Requires `npm install -g vscode-langservers-extracted`
      require("lspconfig").cssls.setup({
        capabilities = capabilities,
        cmd = { "vscode-css-language-server", "--stdio" },
        filetypes = { "css", "less", "sass", "scss" },
        settings = {
          css = { validate = true },
          less = { validate = true },
          sass = { validate = true },
          scss = { validate = true },
        },
      })

      -- HTML
      -- Requires `npm install -g vscode-langservers-extracted`
      lspconfig.html.setup({
        capabilities = capabilities,
        cmd = { "vscode-html-language-server", "--stdio" },
        filetypes = { "html" },
        settings = {
          html = {
            -- See https://code.visualstudio.com/docs/languages/html#_formatting for details.
            format = {
              enable = true,
              extraLiners = "",
              indentHandlebars = true,
              indentInnerHtml = true,
              insertSpaces = true,
              maxPreserveNewLines = 0,  -- explicitly limit preserved newlines
              preserveNewLines = false, -- prevent blank lines
              tabSize = 2,
              unformatted = "pre,code,span",
              wrapLineLength = 120,
            },
          },
        },
      })

      -- PHP Intelephense
      -- Requires PHPCS & Local clone of WordPress.
      -- gh repo clone WordPress/WordPress
      -- NOTE: intelephense covers additional PHP errors that phpcs does not.
      lspconfig.intelephense.setup({
        capabilities = capabilities,
        filetypes = { "php" },
        settings = {
          intelephense = {
            -- For debugging PHPCS disable intelephense.
            -- diagnostics = {
            --   enable = false,
            -- },
            files = {
              maxSize = 1000000,
            },
            format = { enable = false }, -- Disable auto format on save.
            environment = {
              includePaths = {
                vim.fn.expand("~/.intelephense/wp-src/wp-includes"),
                vim.fn.expand("~/.intelephense/wp-src/wp-admin"),
              },
            },
          },
        },
      })

      -- Lua
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }, -- Recognize vim global variable.
            },
          },
        },
      })

      -- Stylelint
      -- Requires stylelint in project root. Ex: `npm init stylelint`.
      require("lspconfig").stylelint_lsp.setup({
        filetypes = { "css", "less", "sass", "scss" },
        root_dir = require("lspconfig").util.root_pattern("package.json", ".git"),
        settings = {
          stylelintplus = {
            -- see available options in stylelint-lsp documentation
          },
        },
        on_attach = function(client)
          client.server_capabilities.document_formatting = false
        end,
      })

      -- TailwindCSS Intelliesense
      -- Requires `npm install -g @tailwindcss/language-server`.
      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
        filetypes = {
          "astro",
          "css",
          "html",
          "javascript",
          "javascriptreact",
          "less",
          "sass",
          "scss",
          "svelte",
          "typescript",
          "typescriptreact",
          "vue",
        },
      })

      -- TypeScript
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        filetypes = {
          "astro",
          "javascript",
          "typescript",
          "vue",
        },
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}

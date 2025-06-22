return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup({
        ensure_installed = {
          "intelephense",
        },
      })
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

      -- HTML LSP requires npm install -g vscode-langservers-extracted
      -- We typically don't want to include this in projects.
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
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        filetypes = {
          "astro",
          "javascript",
          "typescript",
          "vue",
        },
      })
      require("lspconfig").astro.setup({
        capabilities = capabilities,
        on_attach = require("mason-lspconfig").on_attach,
        filetypes = { "astro" },
      })
      -- PHP Intellisense
      lspconfig.intelephense.setup({
        capabilities = capabilities,
        settings = {
          intelephense = {
            files = {
              maxSize = 1000000,
            },
            format = { enable = false }, -- if you're using phpcbf
            environment = {
              includePaths = {
                vim.fn.expand("~/.intelephense/wp-src/wp-includes"),
                vim.fn.expand("~/.intelephense/wp-src/wp-admin"),
              },
            },
          },
        },
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}

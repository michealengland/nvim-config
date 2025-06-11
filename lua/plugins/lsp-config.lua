return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup({
        ensure_installed = {
          "intelephense",
        }
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
          "html",
          "cssls",
          "ts_ls",
          "tailwindcss",
          "lua_ls",
          "intelephense",
        },
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require("lspconfig")

      lspconfig.html.setup({
        capabilities = capabilities
      })
      lspconfig.lua_ls.setup({
        capabilities = capabilities
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
      require'lspconfig'.astro.setup{
        capabilities = capabilities,
        on_attach = require("mason-lspconfig").on_attach,
        filetypes = { "astro" }
      }
      -- PHP Intellisense
      lspconfig.intelephense.setup({
        capabilities = capabilities,
        settings = {
          intelephense = {
            files = {
              maxSize = 1000000;
            };
            format = { enable = false }, -- if you're using phpcbf
            environment = {
              includePaths = {
                vim.fn.expand("~/.intelephense/wp-src/wp-includes"),
                vim.fn.expand("~/.intelephense/wp-src/wp-admin"),
              }
            },
          }
        }
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end
  },
}

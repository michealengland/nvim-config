return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        -- PHPCS diagnostics
        -- Use `command = phpcs` for global OR `./vendor/bin/phpcs"` for project scoped.
        -- Verify your PHPCS in the CL:
        --   Global Scope:  phpcs --standard=WordPress-Core path/to/file.php
        --   Project Scope: /vendor/bin/phpcs --standard=WordPress-Core path/to/file.php
        -- NOTE: intelephense covers additional errors that PHPCS does not catch.
        null_ls.builtins.diagnostics.phpcs.with({
          command = "./vendor/bin/phpcs",
          filetypes = { "php" },
        }),

        -- PHPCBF PHP Code Beautifier (Formatter)
        null_ls.builtins.formatting.phpcbf.with({
          command = "./vendor/bin/phpcbf",
          filetypes = { "php" },
        }),

        -- Stylua (Formatter)
        null_ls.builtins.formatting.stylua,
      },
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}

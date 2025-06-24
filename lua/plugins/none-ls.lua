return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        -- PHPCS diagnostics
        null_ls.builtins.diagnostics.phpcs.with({
          -- Use command = phpcs for global or command = "./vendor/bin/phpcs" for project scoped.
          -- Verify your PHPCS works:
          --   Global Scope:  phpcs --standard=WordPress-Core path/to/file.php
          --   Project Scope: /vendor/bin/phpcs --standard=WordPress-Core path/to/file.php
          --   NOTE: intelephense covers additional errors that PHPCS does not catch.
          command = "./vendor/bin/phpcs",
          filetypes = { "php" },
        }),

        -- PHPCBF PHP Code Beautifier (Formatter)
        null_ls.builtins.formatting.phpcbf.with({
          command = "./vendor/bin/phpcbf",
          args = {
            -- Not specifiying a standard defaults phpcs.xml.
            -- "--standard=WordPress-Extra",
            "-",
          },
          to_stdin = true,
          extra_args = {}, -- <- Silences most warnings
        }),

        -- Stylua (Formatter)
        null_ls.builtins.formatting.stylua,
      },
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}

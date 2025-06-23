return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        -- PHPCS diagnostics
        null_ls.builtins.diagnostics.phpcs.with({
          command = "phpcs",
          args = {
            "--standard=phpcs.xml",
            "--report=emacs",
            "-",
          },
          -- Ensures PHPCS uses project root phpcs.xml
          cwd = function(params)
            return vim.fn.getcwd()
          end,
        }),

        -- PHPCBF PHP Code Beautifier (Formatter)
        null_ls.builtins.formatting.phpcbf.with({
          command = "./vendor/bin/phpcbf",
          args = { "--standard=WordPress", "-" },
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

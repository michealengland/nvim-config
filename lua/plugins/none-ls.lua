return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        -- PHPCS diagnostics
        null_ls.builtins.diagnostics.phpcs.with({
          command = "phpcs", -- Use full path if needed
          args = {
            "--standard=phpcs.xml",
            "--report=emacs",
            "-",
          },
          cwd = function(params)
            -- Ensures it picks up your theme-local phpcs.xml
            return vim.fn.getcwd()
          end,
        }),
        null_ls.builtins.formatting.phpcbf.with({
          command = "./vendor/bin/phpcbf",
          args = { "--standard=WordPress", "-" },
          to_stdin = true,
          extra_args = {}, -- <- Silences most warnings
        }),
      },
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}

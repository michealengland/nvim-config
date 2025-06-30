return {
  "nvim-pack/nvim-spectre",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    vim.keymap.set("n", "<leader>S", function()
      require("spectre").toggle()
    end, { desc = "Toggle Spectre" })
  end,
}

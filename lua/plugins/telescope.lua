return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" }, -- Ensure dependencies are loaded
  opts = { -- 👈 Add this block
    defaults = {
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
    },
  },
  keys = function()
    local telBuiltin = require("telescope.builtin")
    return {
      { "<leader>ff", telBuiltin.find_files, desc = "Find Files" },
      { "<C-p>", telBuiltin.git_files, desc = "Find Git Files" },
      {
        "<leader>fw",
        function()
          telBuiltin.grep_string({ search = vim.fn.input("Grep > ") })
        end,
        desc = "Search for Word",
      },
    }
  end,
}

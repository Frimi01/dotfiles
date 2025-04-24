return {
  "nvim-treesitter/nvim-treesitter",
  run = ":TSUpdate",
  opts = {
    ensure_installed = { "java", "json", "lua", "bash", "yaml" },
    highlight = { enable = true },
  },
}

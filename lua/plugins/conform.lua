return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      python = { "black" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      json = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      markdown = { "prettier" },
      yaml = { "prettier" },
      rust = { "rustfmt" },
    },
  },
}

return {
  "catppuccin/nvim", -- Replace with your preferred colorscheme plugin
  name = "catppuccin",
  lazy = false,
  config = function()
    function ColorMyPencils(color)
      color = color or "catppuccin"
      require("catppuccin").setup({
        flavour = "mocha", -- Change to "mocha" for higher contrast
      })
      vim.cmd.colorscheme(color)

      -- Set all backgrounds to none (full transparency)
      local hl_groups = {
        "Normal",
        "NormalNC",
        "NormalFloat",
        "FloatBorder",
        "TelescopeNormal",
        "TelescopePromptNormal",
        "TelescopePromptBorder",
        "TelescopeResultsNormal",
        "TelescopeResultsBorder",
        "TelescopePreviewNormal",
        "TelescopePreviewBorder",
        "Pmenu",
        "PmenuSel",
        "PmenuSbar",
        "PmenuThumb",
        "WinSeparator",
        "StatusLine",
        "StatusLineNC",
        "CursorLine",
        "CursorLineNr",
        "LineNr",
        "SignColumn",
        "VertSplit",
      }

      for _, group in ipairs(hl_groups) do
        vim.api.nvim_set_hl(0, group, { bg = "none" })
      end
    end

    ColorMyPencils()
  end,
}

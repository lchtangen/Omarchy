-- Neovim colorscheme for this theme
-- Usage: :lua require('omarchy-theme').setup()
local M = {}

M.colors = {
  bg = "#1a1b26",
  fg = "#c0caf5",
  -- Add all 16 ANSI colors + extras
}

function M.setup()
  vim.cmd("hi Normal guibg=#1a1b26 guifg=#c0caf5")
  vim.cmd("hi Comment guifg=#414868")
  vim.cmd("hi Constant guifg=#bb9af7")
  vim.cmd("hi String guifg=#9ece6a")
  vim.cmd("hi Function guifg=#7aa2f7")
  vim.cmd("hi Keyword guifg=#f7768e")
  vim.cmd("hi Type guifg=#e0af68")
end

return M

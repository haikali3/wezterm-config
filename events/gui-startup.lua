local wezterm = require('wezterm')
local mux = wezterm.mux

local M = {}

M.setup = function()
   wezterm.on('gui-startup', function(cmd)
      local _, _, window = mux.spawn_window(cmd or {})
      local gui_window = window:gui_window()

      -- Get the screen dimensions
      local screen = wezterm.gui.screens().active
      local screen_width = screen.width
      local screen_height = screen.height

      -- Set window to right half of screen
      gui_window:set_position(screen_width / 2, 0)
      gui_window:set_inner_size(screen_width / 2, screen_height)
   end)
end

return M

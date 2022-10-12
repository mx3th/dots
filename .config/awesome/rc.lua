-- Modules
pcall(require, "luarocks.loader")

local awful = require("awful")
local gears = require("gears")
require("awful.autofocus")
local beautiful = require("beautiful")
local menubar = require("menubar")

-- Theme
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/theme.lua")

-- Variables
terminal = "kitty"
editor = "lvim"
editor_cmd = terminal .. " -e " .. editor
web = "brave"
rofi = "rofi -show drun -theme " .. gears.filesystem.get_configuration_dir() .. "theme/rofi.rasi"
files = "thunar"
music = "spotify"

-- Layouts
awful.layout.layouts = {
  awful.layout.suit.floating,
  awful.layout.suit.tile,
}

-- Menu
menubar.utils.terminal = terminal -- Set the terminal for applications that require it

myawesomemenu = {
  { "edit config", editor_cmd .. " " .. awesome.conffile },
  { "restart", awesome.restart },
  { "quit", function() awesome.quit() end },
}

appsmenu = {
  { "web", web },
  { "spotify", music},
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu },
  { "apps", appsmenu },
  { "files", files},
  { "terminal", terminal }
}
})

-- Modules
require("main")
require("bar")

local awful = require("awful")
local gears = require("gears")

awful.spawn.with_shell("~/.fehbg")
awful.spawn.with_shell("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
awful.spawn.with_shell("picom --config " .. gears.filesystem.get_configuration_dir() .. "main/picom.conf")
awful.spawn.with_shell("nm-applet")
awful.spawn.with_shell("coolero")

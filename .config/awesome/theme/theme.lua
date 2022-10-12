local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gears = require("gears")

local gfs = require("gears.filesystem")
-- local themes_path = gfs.get_themes_dir()

local theme = {}

-- Font
theme.font = "SAGA Heavy 12"

-- Colors
theme.bg_normal   = "#1d2021"
theme.bg_focus    = "#32302f"
theme.bg_urgent   = "#cc241d"
theme.bg_minimize = "#282828"
theme.bg_systray  = theme.bg_normal

theme.fg_normal   = "#ebdbb2"
theme.fg_focus    = "#ebdbb2"
theme.fg_urgent   = "#ebdbb2"
theme.fg_minimize = "#ebdbb2"

theme.useless_gap   = dpi(16)
theme.border_width  = dpi(0)
theme.border_normal = "#282828"
theme.border_focus  = "#32302f"
theme.border_marked = "#cc241d"

theme.yellow = "#d79921"
theme.purple = "#b16286"

-- Wibar
theme.wibar_height = dpi(40)

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming notifications:
-- theme.notification_font = "SAGA Heavy 12"
-- notification_[bg|fg]
-- notification_[width/height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Menu
theme.menu_height = dpi(35)
theme.menu_width  = dpi(200)
theme.submenu = "> "

-- {{{ Titlebar
local titlebar_icon_dir = gfs.get_configuration_dir() .. "/theme/assets/titlebar/"
theme.titlebar_bg = theme.bg_normal

-- Close Button
theme.titlebar_close_button_normal = gears.color.recolor_image(titlebar_icon_dir .. "normal.svg", theme.bg_minimize)
theme.titlebar_close_button_focus = titlebar_icon_dir .. "close_focus.svg"
theme.titlebar_close_button_normal_hover = titlebar_icon_dir .. "close_focus_hover.svg"
theme.titlebar_close_button_focus_hover = titlebar_icon_dir .. "close_focus_hover.svg"

-- Minimize Button
theme.titlebar_minimize_button_normal = gears.color.recolor_image(titlebar_icon_dir .. "normal.svg", theme.bg_minimize)
theme.titlebar_minimize_button_focus = titlebar_icon_dir .. "minimize_focus.svg"
theme.titlebar_minimize_button_normal_hover = titlebar_icon_dir .. "minimize_focus_hover.svg"
theme.titlebar_minimize_button_focus_hover = titlebar_icon_dir .. "minimize_focus_hover.svg"

-- Maximized Button (While Window is Maximized)
theme.titlebar_maximized_button_normal_active = gears.color.recolor_image(titlebar_icon_dir .. "normal.svg", theme.bg_minimize)
theme.titlebar_maximized_button_focus_active = titlebar_icon_dir .. "maximized_focus.svg"
theme.titlebar_maximized_button_normal_active_hover = titlebar_icon_dir .. "maximized_focus_hover.svg"
theme.titlebar_maximized_button_focus_active_hover = titlebar_icon_dir .. "maximized_focus_hover.svg"

-- Maximized Button (While Window is not Maximized)
theme.titlebar_maximized_button_normal_inactive = gears.color.recolor_image(titlebar_icon_dir .. "normal.svg", theme.bg_minimize)
theme.titlebar_maximized_button_focus_inactive = titlebar_icon_dir .. "maximized_focus.svg"
theme.titlebar_maximized_button_normal_inactive_hover = titlebar_icon_dir .. "maximized_focus_hover.svg"
theme.titlebar_maximized_button_focus_inactive_hover = titlebar_icon_dir .. "maximized_focus_hover.svg"
--- }}}


-- Layout Icons
local layout_icon_dir = gfs.get_configuration_dir() .. "/theme/assets/layout/"

theme.layout_floating = gears.color.recolor_image(layout_icon_dir .. "floating.png", theme.fg_normal)
theme.layout_tile     = gears.color.recolor_image(layout_icon_dir .. "tile.png", theme.fg_normal)

-- Systray
theme.systray_icon_spacing = dpi(10)

-- Tasklist
theme.tasklist_disable_icon = true

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80

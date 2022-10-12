local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- Volume
local volume = wibox.widget.textbox()
volume.font = "SAGA Heavy 14"

local percentage = wibox.widget.textbox()

awesome.connect_signal("signal::volume", function(vol, mute)
	vol = tonumber(vol)
	if mute or vol == 0 then
		volume.markup = "<span foreground='"..beautiful.fg_normal.."'>󰸈 </span>"
		percentage.markup = "M"
	else
		if vol < 20 then
			volume.markup = "<span foreground='"..beautiful.fg_normal.."'>󰕿 </span>"
			percentage.markup = vol .. "%"
		elseif vol < 60 then
			volume.markup = "<span foreground='"..beautiful.fg_normal.."'>󰖀 </span>"
			percentage.markup = vol .. "%"
		else
			volume.markup = "<span foreground='"..beautiful.fg_normal.."'>󰕾 </span>"
			percentage.markup = vol .. "%"
		end
	end
end)

-- Launcher
local launcher = wibox.widget.textbox()
launcher.markup = ""

launcher:connect_signal("mouse::enter", function()
	launcher.markup = "<span foreground='"..beautiful.bg_focus.."'></span>"
end)

launcher:connect_signal("mouse::leave", function()
	launcher.markup = ""
end)

launcher:buttons(gears.table.join(
	awful.button({ }, 1, function()
		awful.spawn("rofi -show drun", false)
	end)
))

-- Systray
local systray = wibox.widget {
  {
    wibox.widget.systray,
    layout = wibox.layout.fixed.horizontal,
  },
  margins = { top = dpi(8), bottom = dpi(8), left = dpi(8), right = dpi(8) },
  widget = wibox.container.margin,
}

-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
  awful.button({}, 1, function(t) t:view_only() end),
  awful.button({ modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
  awful.button({}, 1, function(c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal(
        "request::activate",
        "tasklist",
        { raise = true }
      )
    end
  end),
  awful.button({}, 3, function()
    awful.menu.client_list({ theme = { width = 250 } })
  end),
  awful.button({}, 4, function()
    awful.client.focus.byidx(1)
  end),
  awful.button({}, 5, function()
    awful.client.focus.byidx(-1)
  end))

awful.screen.connect_for_each_screen(function(s)

  -- Each screen has its own tag table.
  awful.tag({ "1", "2", "3", "4" }, s, awful.layout.layouts[1])

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.

  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({}, 1, function() awful.layout.inc(1) end),
    awful.button({}, 3, function() awful.layout.inc(-1) end),
    awful.button({}, 4, function() awful.layout.inc(1) end),
    awful.button({}, 5, function() awful.layout.inc(-1) end)))

  -- Launcher Container
  s.launcher = wibox.widget {
    {
      launcher,
      layout = wibox.layout.fixed.horizontal,
    },
    margins = { top = dpi(8), bottom = dpi(8), left = dpi(8), right = dpi(8) },
    widget = wibox.container.margin,
  }

  -- Volume Container
  s.volume = wibox.widget {
    {
      volume,
	    percentage,
	    layout = wibox.layout.fixed.horizontal,
    },
    margins = { top = dpi(8), bottom = dpi(8), left = dpi(8), right = dpi(8) },
    widget = wibox.container.margin,
  }

  -- Layoutbox Container
  s.layoutbox = wibox.widget {
    {
      s.mylayoutbox,
      layout = wibox.layout.fixed.horizontal,
    },
    margins = { top = dpi(8), bottom = dpi(8), left = dpi(8), right = dpi(8) },
    widget = wibox.container.margin,
  }

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    buttons = taglist_buttons
  }

  -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

  -- Create the wibox
  s.mywibox = awful.wibar({ position = "top", screen = s })

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      s.launcher,
      s.mytaglist,
    },
    s.mytasklist, -- Middle widget
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      systray,
      s.volume,
      mytextclock,
      s.layoutbox,
    },
  }
end)


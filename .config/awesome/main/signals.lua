local awful = require("awful")
local beautiful = require("beautiful")

local gears = require "gears"

-- Volume Signal

local vol_sc = 'pamixer --get-volume'
local mute_sc = 'pamixer --get-mute'

local function get_vol()
	awful.spawn.easy_async_with_shell(vol_sc, function(vol)
		awful.spawn.easy_async_with_shell(mute_sc, function(mute)
			if mute:match("false") then 
				muted = false
			else
				muted = true
			end

			awesome.emit_signal("signal::volume", vol, muted)
		end)
	end)
end
	
gears.timer {
	timeout = 2,
	call_now = true,
	autostart = true,
	callback = function()
		get_vol()
	end
}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end
  
    if awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position then
      -- Prevent clients from being unreachable after screen count changes.
      awful.placement.no_offscreen(c)
    end
  end)
  
  -- Enable sloppy focus, so that focus follows mouse.
  client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", { raise = false })
  end)
  
  client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
  client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
  -- }}}
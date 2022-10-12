local awful = require("awful")
local menubar = require("menubar")
mod = "Mod4"
ctrl = "Control"
shift = "Shift"

-- {{{ Key bindings
awful.keyboard.append_global_keybindings({
  awful.key({ mod, }, "Left", awful.tag.viewprev),
  awful.key({ mod, }, "Right", awful.tag.viewnext),
  awful.key({ mod, }, "Escape", awful.tag.history.restore),

  -- Focus
  awful.key({ mod, }, "j", function() awful.client.focus.byidx(1) end),
  awful.key({ mod, }, "k", function() awful.client.focus.byidx(-1) end),

  -- Layout manipulation
  awful.key({ mod, "Shift" }, "j", function() awful.client.swap.byidx(1) end),
  awful.key({ mod, "Shift" }, "k", function() awful.client.swap.byidx(-1) end),
  awful.key({ mod, "Control" }, "j", function() awful.screen.focus_relative(1) end),
  awful.key({ mod, "Control" }, "k", function() awful.screen.focus_relative(-1) end),
  awful.key({ mod, }, "u", awful.client.urgent.jumpto),

  -- Standard program
  awful.key({ mod, }, "Return", function() awful.spawn(terminal) end),
  awful.key({ mod, }, "b", function() awful.spawn(web) end),
  awful.key({ mod, shift }, "b", function() awful.spawn(web .. " --incognito") end),
  awful.key({ mod, shift }, "f", function() awful.spawn(terminal .. " ranger") end),

  awful.key({ mod, "Control" }, "r", awesome.restart),
  awful.key({ mod, "Control" }, "q", awesome.quit),

  awful.key({ mod, }, "l", function() awful.tag.incmwfact(0.05) end),
  awful.key({ mod, }, "h", function() awful.tag.incmwfact(-0.05) end),
  awful.key({ mod, }, "space", function() awful.layout.inc(1) end),
  awful.key({ mod, "Shift" }, "space", function() awful.layout.inc(-1) end),

  -- Restore Minimized
  awful.key({ mod, "Control" }, "n",
    function()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        c:emit_signal(
          "request::activate", "key.unminimize", { raise = true }
        )
      end
    end,
    { description = "restore minimized", group = "client" }),

  -- Rofi
  awful.key({ mod }, "r", function() awful.spawn(rofi) end),
  -- Menubar
  awful.key({ mod }, "p", function() menubar.show() end),
})

-- Client
awful.keyboard.append_client_keybindings({
  awful.key({ mod, }, "f",
    function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    { description = "toggle fullscreen", group = "client" }),
  awful.key({ mod }, "q", function(c) c:kill() end,
    { description = "close", group = "client" }),
  awful.key({ mod, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end,
    { description = "move to master", group = "client" }),
  awful.key({ mod, }, "o", function(c) c:move_to_screen() end,
    { description = "move to screen", group = "client" }),
  awful.key({ mod, }, "t", function(c) c.ontop = not c.ontop end,
    { description = "toggle keep on top", group = "client" }),
  awful.key({ mod, }, "n",
    function(c)
      -- The client currently has the input focus, so it cannot be
      -- minimized, since minimized clients can't have the focus.
      c.minimized = true
    end,
    { description = "minimize", group = "client" }),
  awful.key({ mod, }, 'y', awful.titlebar.toggle),
})


-- Tags
awful.keyboard.append_global_keybindings({
  awful.key {
    modifiers   = { mod },
    keygroup    = "numrow",
    description = "only view tag",
    group       = "tag",
    on_press    = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        tag:view_only()
      end
    end,
  },
  awful.key {
    modifiers   = { mod, "Control" },
    keygroup    = "numrow",
    description = "toggle tag",
    group       = "tag",
    on_press    = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end,
  },
  awful.key {
    modifiers   = { mod, "Shift" },
    keygroup    = "numrow",
    description = "move focused client to tag",
    group       = "tag",
    on_press    = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end,
  },
  awful.key {
    modifiers   = { mod, "Control", "Shift" },
    keygroup    = "numrow",
    description = "toggle focused client on tag",
    group       = "tag",
    on_press    = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:toggle_tag(tag)
        end
      end
    end,
  }
})

-- Mouse bindings
awful.mouse.append_global_mousebindings({
  awful.button({}, 3, function() mymainmenu:toggle() end)
})

client.connect_signal("request::default_mousebindings", function()
  awful.mouse.append_client_mousebindings({
    awful.button({}, 1, function(c) c:activate { context = "mouse_click" } end),
    awful.button({ mod }, 1, function(c) c:activate { context = "mouse_click", action = "mouse_move" } end),
    awful.button({ mod }, 3, function(c) c:activate { context = "mouse_click", action = "mouse_resize" } end),
    awful.button({ mod }, 1, awful.client.floating.toggle),
  })
end)

-- Media Keys
awful.keyboard.append_global_keybindings({

  -- Volume
  awful.key({}, "XF86AudioRaiseVolume", function() awful.spawn("pamixer -i 5") end),
  awful.key({}, "XF86AudioLowerVolume", function() awful.spawn("pamixer -d 5") end),
  awful.key({}, "XF86AudioMute", function() awful.spawn("pamixer -t") end),

  -- Media
  awful.key({}, "XF86AudioPlay", function() awful.spawn("playerctl play-pause") end),
  awful.key({}, "XF86AudioNext", function() awful.spawn("playerctl next") end),
  awful.key({}, "XF86AudioPrev", function() awful.spawn("playerctl previous") end),
  awful.key({}, "XF86AudioStop", function() awful.spawn("playerctl stop") end),
})

local awful = require("awful")
local menubar = require("menubar")

local focus = {
    next = function()
        awful.client.focus.byidx(1)
        if client.focus then client.focus:raise() end
    end,
    previous = function()
        awful.client.focus.byidx(-1)
        if client.focus then client.focus:raise() end
    end,
    last = function()
        awful.client.focus.history.previous()
        if client.focus then
            client.focus:raise()
        end
    end
}

local prompt = {
    lua = function()
        awful.prompt.run({ prompt = "Run Lua code: " },
        mypromptbox[mouse.screen].widget,
        awful.util.eval, nil,
        awful.util.getdir("cache") .. "/history_eval")
    end
}

local client = {
    maximize = function(c)
        c.maximized_horizontal = not c.maximized_horizontal
        c.maximized_vertical = not c.maximized_vertical
    end,
    minimize = function(c)
        c.minimized = true
    end
}

local audio = {
    mute = function()
        os.execute("amixer sset Master toggle")
    end,
    lower = function()
        os.execute("amixer sset Master 5%-")
    end,
    raise = function()
        os.execute("amixer sset Master 5%+")
    end
}

globalkeys = awful.util.table.join(
    awful.key({ modkey, "Control" }, "l", function() awful.util.spawn("xscreensaver-command -lock") end),
    awful.key({}, "XF86AudioMute", audio.mute),
    awful.key({}, "XF86AudioLowerVolume", audio.lower),
    awful.key({}, "XF86AudioRaiseVolume", audio.raise),
    awful.key({}, "XF86MonBrightnessUp", function() os.execute("light -A 5") end),
    awful.key({}, "XF86MonBrightnessDown", function() os.execute("light -U 5") end),
    awful.key({ modkey, }, "Left", awful.tag.viewprev),
    awful.key({ modkey, }, "Right", awful.tag.viewnext),
    awful.key({ modkey, }, "Escape", awful.tag.history.restore),
    awful.key({ modkey, }, "j", focus.next),
    awful.key({ modkey, }, "k", focus.previous),
    awful.key({ modkey, }, "w", function() mymainmenu:show() end),
    awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end),
    awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end),
    awful.key({ modkey, "Control" }, "j", function() awful.screen.focus_relative(1) end),
    awful.key({ modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end),
    awful.key({ modkey, }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey, }, "Tab",   focus.last),
    awful.key({ modkey, }, "Return", function() awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift" }, "q", awesome.quit),
    awful.key({ modkey, }, "l", function() awful.tag.incmwfact(0.05) end),
    awful.key({ modkey, }, "h", function() awful.tag.incmwfact(-0.05) end),
    awful.key({ modkey, "Shift" }, "h", function() awful.tag.incnmaster(1) end),
    awful.key({ modkey, "Shift" }, "l", function() awful.tag.incnmaster(-1) end),
    awful.key({ modkey, "Control" }, "h", function() awful.tag.incncol(1) end),
    awful.key({ modkey, "Control" }, "l", function() awful.tag.incncol(-1) end),
    awful.key({ modkey, }, "space", function() awful.layout.inc(layouts, 1) end),
    awful.key({ modkey, "Shift" }, "space", function() awful.layout.inc(layouts, -1) end),
    awful.key({ modkey, "Control" }, "n", awful.client.restore),
    awful.key({ modkey }, "r", function() mypromptbox[mouse.screen]:run() end),
    awful.key({ modkey }, "x", prompt.lua),
    awful.key({ modkey }, "p", function() menubar.show() end))

clientkeys = awful.util.table.join(
    awful.key({ modkey, }, "f", function(c) c.fullscreen = not c.fullscreen end),
    awful.key({ modkey, "Shift" }, "c", function(c) c:kill() end),
    awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle),
    awful.key({ modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey, }, "o", awful.client.movetoscreen),
    awful.key({ modkey, }, "t", function(c) c.ontop = not c.ontop end),
    awful.key({ modkey, }, "n", client.minimize ),
    awful.key({ modkey, }, "m", client.maximize ),
    awful.key({}, "Print", function() awful.util.spawn("screenshot") end))

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
            function()
                local screen = mouse.screen
                local tag = awful.tag.gettags(screen)[i]
                if tag then
                    awful.tag.viewonly(tag)
                end
            end),
        -- Toggle tag.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
            function()
                local screen = mouse.screen
                local tag = awful.tag.gettags(screen)[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = awful.tag.gettags(client.focus.screen)[i]
                    if tag then
                        awful.client.movetotag(tag)
                    end
                end
            end),
        -- Toggle tag.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = awful.tag.gettags(client.focus.screen)[i]
                    if tag then
                        awful.client.toggletag(tag)
                    end
                end
            end))
end

clientbuttons = awful.util.table.join(awful.button({}, 1, function(c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)


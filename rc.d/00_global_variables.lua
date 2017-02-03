local beautiful = require("beautiful")
local awful = require("awful")
local wibox = require("wibox")

modkey = "Mod4"
-- Themes define colours, icons, font and wallpapers.
beautiful.init("~/.config/awesome/themes/zenburn/theme.lua")


-- This is used later as the default terminal and editor to run.
terminal = "termite"
editor = os.getenv("EDITOR") or "vi"
editor_cmd = terminal .. " -e " .. editor


-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}
-- }}}





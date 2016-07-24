local awful = require("awful")

os.execute("killall nm-applet")
awful.util.spawn("nm-applet")

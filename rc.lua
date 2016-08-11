local configFiles = io.popen("ls -d ~/.config/awesome/rc.d/*.lua")
for file in configFiles:lines() do
    dofile(file)
end
configFiles:close()

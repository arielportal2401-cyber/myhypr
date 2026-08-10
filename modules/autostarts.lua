hl.on("hyprland.start", function ()
  hl.exec_cmd("qs")
  hl.exec_cmd("awww-daemon")
  hl.exec_cmd("pypr")
  hl.exec_cmd("swaync")
  hl.exec_cmd("usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
  hl.exec_cmd("hypridle")
end)


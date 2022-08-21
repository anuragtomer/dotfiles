local hyper = { "cmd", "alt", "ctrl", "shift" }

hs.hotkey.bind(hyper, "0", function()
    hs.reload()
end)

hs.notify.new({title="Hammerspoon", informativeText="Config loaded"}):send()

local applicationHotkeys = {
  g = '/Applications/Brave Browser.app/Contents/MacOS/Brave Browser',
  t = '/Applications/Alacritty.app',
  a = '/Applications/Visual Studio Code.app/Contents/MacOS/Electron',
  m = '/System/Applications/Mail.app/Contents/MacOS/Mail',
  s = '/Applications/Slack.app/Contents/MacOS/Slack',
  c = '/System/Applications/Music.app/Contents/MacOS/Music',
  o = '/Applications/zoom.us.app/Contents/MacOS/zoom.us',
  p = '/Applications/PDF Expert.app/Contents/MacOS/PDF Expert',
  e = '/Applications/Spotify.app/Contents/MacOS/Spotify'
}
for key, app in pairs(applicationHotkeys) do
  hs.hotkey.bind(hyper, key, function()
    hs.application.launchOrFocus(app)
  end)
end


hs.window.animationDuration = 0
hs.hotkey.bind(hyper, "h", function()
  local win = hs.window.focusedWindow();
  if not win then return end
win:moveToUnit(hs.layout.left50)
end)
hs.hotkey.bind(hyper, "j", function()
  local win = hs.window.focusedWindow();
  if not win then return end
win:moveToUnit(hs.layout.maximized)
end)
hs.hotkey.bind(hyper, "k", function()
  local win = hs.window.focusedWindow();
  if not win then return end
win:moveToScreen(win:screen():next())
end)
hs.hotkey.bind(hyper, "l", function()
  local win = hs.window.focusedWindow();
  if not win then return end
win:moveToUnit(hs.layout.right50)
end)

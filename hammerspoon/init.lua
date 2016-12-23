-- reload with R
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)
hs.alert.show("Config loaded")

-- scripts
dofile("lib/window-positioning.lua")

-- Vendor additions
dofile("vendor/anycomplete/anycomplete.lua")


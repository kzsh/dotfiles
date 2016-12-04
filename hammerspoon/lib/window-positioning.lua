-- General config
local modifier_keys = {"cmd", "shift"}
hs.window.animationDuration = 0

local ALERT_STYLES = {textFont = 'Menlo Regular', strokeColor = {1,0} }
local lastAlert = nil

local mappings = {
  h = { x = {'x', 1}, y = {'y',1}, h = {'h', 1}, w = {'w', 0.5} },
  j = { x = {'x', 1}, y = {'h',0.5}, h = {'h', 0.5}, w = {'w', 1} },
  k = { x = {'x', 1}, y = {'y',1}, h = {'h', 0.5}, w = {'w', 1} },
  l = { x = {'w', 0.5}, y = {'y',1}, h = {'h', 1}, w = {'w', 0.5} },
  m = { x = {'x', 1}, y = {'y',1}, h = {'h', 1}, w = {'w', 1} }
}

local directionCharacterMap = {
  h = ' ← ',
  j = ' ↓ ',
  k = ' ↑ ',
  l = ' → ',
  m = '  ↑\n←   →\n  ↓'
}

function applyDimensionModifiers(dimensions, dimensionModifiers)
  return {
    x = dimensions[dimensionModifiers.x[1]] * dimensionModifiers.x[2],
    y = dimensions[dimensionModifiers.y[1]] * dimensionModifiers.y[2],
    h = dimensions[dimensionModifiers.h[1]] * dimensionModifiers.h[2],
    w = dimensions[dimensionModifiers.w[1]] * dimensionModifiers.w[2]
  }
end


-- Bindings
for binding, dimensionModifiers in pairs(mappings) do  -- Table iteration.
  hs.hotkey.bind(modifier_keys, binding, function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local dimensions = applyDimensionModifiers(screen:frame(), dimensionModifiers)

    f.x = dimensions.x
    f.y = dimensions.y
    f.w = dimensions.w
    f.h = dimensions.h
    win:setFrame(f)
    if lastAlert then hs.alert.closeSpecific(lastAlert, 0) end
    lastAlert = hs.alert(directionCharacterMap[binding], ALERT_STYLES )
  end)
end

hs.hotkey.bind(modifier_keys, ',', function()
  local win = hs.window.focusedWindow()
  local screen = win:screen():previous()
  win:moveToScreen(screen)
  if lastAlert then hs.alert.closeSpecific(lastAlert, 0) end
  lastAlert = hs.alert.show("Prev Monitor", ALERT_STYLES)
end)

hs.hotkey.bind(modifier_keys, '.', function()
  local win = hs.window.focusedWindow()
  local screen = win:screen():next()
  if lastAlert then hs.alert.closeSpecific(lastAlert, 0) end
  win:moveToScreen(screen)
  lastAlert = hs.alert.show("Next Monitor", ALERT_STYLES)
end)

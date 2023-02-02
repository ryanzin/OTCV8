local mainTab = tabs:getTab('Tools') and 'Tools' or 'Main'
setDefaultTab(mainTab)


local bugMap = {}

bugMap.checkBox = setupUI([[
CheckBox
  id: checkBox
  font: cipsoftFont
  text: Use Diagonal
]])

bugMap.checkBox.onCheckChange = function(widget, checked)
    storage.bugMapCheck = checked
end

storage.bugMapCheck = storage.bugMapCheck or true

bugMap.checkBox:setChecked(storage.bugMapCheck)

bugMap.isKeyPressed = modules.corelib.g_keyboard.isKeyPressed

bugMap.directions = {
    ["W"] = {x = 0, y = -5, direction = 0},
    ["E"] = {x = 3, y = -3},
    ["D"] = {x = 5, y = 0, direction = 1},
    ["C"] = {x = 3, y = 3},
    ["S"] = {x = 0, y = 5, direction = 2},
    ["Z"] = {x = -3, y = 3},
    ["A"] = {x = -5, y = 0, direction = 3},
    ["Q"] = {x = -3, y = 3}
}

bugMap.macro = macro(1, "Bug Map", function()
    if modules.game_console:isChatEnabled() then return end
    local pos = pos()
    for key, config in pairs(bugMap.directions) do
        if bugMap.isKeyPressed(key) then
            if storage.bugMapCheck or config.direction then
                if config.direction then turn(config.direction) end
                local tile = g_map.getTile({x = pos.x + config.y, y = config.y, z = pos.z})
                if tile then
                    return g_game.use(tile:getTopUseThing())
                end
            end
        end
    end
end)

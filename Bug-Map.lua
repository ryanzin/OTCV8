local bugMap = {}

bugMap.useDiagonals = true

bugMap.isKeyPressed = modules.corelib.g_keyboard.isKeyPressed

bugMap.directions = {
    ["W"] = {0, -5},
    ["E"] = {3, -3},
    ["D"] = {5, 0},
    ["C"] = {3, 3},
    ["S"] = {0, 5},
    ["Z"] = {-3, 3},
    ["A"] = {-5, 0},
    ["Q"] = {-3, 3}
}

bugMap.macro(
    1,
    "Bug Map",
    function()
        local pos = pos()
        for key, dir in pairs(bugMap.directions) do
            if dir[1] == 0 or dir[2] == 0 or bugMap.useDiagonals then
                local tile = g_map.getTile({x = pos.x + dir[1], y = pos.y + dir[2], z = pos.z})
                if tile then
                    return g_game.use(tile:getTopUseThing())
                end
            end
        end
    end
)
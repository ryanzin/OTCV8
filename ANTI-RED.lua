Combo = {
    "",
    "",
    "",
    ""
}

local timeArea = 0
macro(
    1,
    "Anti-Red",
    function()
        local pos = pos()
        MonstersCount = 0
        for _, spec in ipairs(getSpectators(true)) do
            if MonstersCount > 1 or timeArea > now then
                break
            end
            local specPos = spec:getPosition()
            local checkPosz = math.abs(specPos.z - pos.z)
            if checkPosz <= 3 then
                if
                    (spec ~= player and spec:isPlayer() and spec:getEmblem() ~= 1 and spec:getShield() < 3) or
                        player:getSkull() >= 3
                 then
                    timeArea = now + 30000
                    break
                elseif checkPosz == 0 and spec:isMonster() and getDistanceBetween(specPos, pos) == 1 then
                    MonstersCount = MonstersCount + 1
                end
            end
        end
        if MonstersCount > 1 and (not timeArea or timeArea < now) then
            return say("area")
        end
        if not g_game.isAttacking() then
            return
        end
        for _, spell in ipairs(Combo) do
            say(spell)
        end
    end
)

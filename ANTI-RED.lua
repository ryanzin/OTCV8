setDefaultTab('Tools')



addTextEdit("Magias", storage.comboSpells or "magia1, magia2, magia3", function(widget, text)
	storage.comboSpells = text
end)

addTextEdit("Area", storage.areaSpell or "Magia de Area", function(widget, text)
	storage.areaSpell = text
end)

local timeArea = 0
macro(
    1,
    "Anti-Red",
    function()
        local pos = pos()
        local monstersCount = 0
        for _, spec in pairs(getSpectators(true)) do
            if monstersCount > 1 or timeArea > now then
                break
            end
            local specPos = spec:getPosition()
            local checkPosz = math.abs(specPos.z - pos.z)
            if checkPosz <= 3 then
                if
                    (spec ~= player and spec:isPlayer() and spec:getEmblem() ~= 1 and spec:getShield() < 3) or player:getSkull() >= 3
                 then
                    timeArea = now + 30000
                    break
                elseif checkPosz == 0 and spec:isMonster() and getDistanceBetween(specPos, pos) == 1 then
                    monstersCount = monstersCount + 1
                end
            end
        end
        if monstersCount > 1 and (not timeArea or timeArea < now) then
            return say(storage.areaSpell)
        end
        if not g_game.isAttacking() then
            return
        end
        for _, spell in ipairs(storage.comboSpells:split(',')) do
            say(spell)
        end
    end
)

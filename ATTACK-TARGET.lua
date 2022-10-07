local keepTarget = {}

keepTarget.keyCancel = "Escape"

keepTarget.macro =
    macro(
    1,
    "Attack target",
    function()
        if modules.corelib.g_keyboard.isKeyPressed(keepTarget.keyCancel) then
            keepTarget.storageId = nil
            return g_game.cancelAttack()
        end
        local target = g_game.getAttackingCreature()
        if target then
            local targetId = target:getId()
            if keepTarget.storageId ~= targetId then
                keepTarget.storageId = targetId
            end
            return
        else
            if keepTarget.storageId then
                local findCreature = getCreatureById(keepTarget.storageId)
                if findCreature then
                    g_game.attack(findCreature)
                    return delay(500)
                else
                    return delay(100)
                end
            end
        end
    end
)

local keepTarget = {}

keepTarget.keyCancel = "Escape"

keepTarget.macro =
    macro(
    1,
    "Attack target",
    function()
        if modules.corelib.g_keyboard.isKeyPressed(keepTarget.keepTarget) then
            keepTarget.storageId = nil
            return g_game.cancelAttack()
        end
        local target = g_game.getAttackingCreature()
        if target then
            if keepTarget.storageId ~= target:getId() then
                keepTarget.storageId = target:getId()
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

macro(1, 'xSense', 'F12', function()
    if storage.Sense then
        locatePlayer = getPlayerByName(storage.Sense)
        if not (locatePlayer and locatePlayer:getPosition().z == player:getPosition().z and getDistanceBetween(pos(), locatePlayer:getPosition()) <= 6) then
            say('sense "' .. storage.Sense)
            delay(1000)
        end
    end
end, mainTab)


onTalk(function(name, level, mode, text, channelId, pos)
    if player:getName() == name then
        if string.sub(text, 1, 1):lower() == 'x' then
            local checkMsg = string.sub(text, 2):trim()
            if checkMsg == '0' then
                storage.Sense = false
            else
                storage.Sense = checkMsg
            end
        end
    end
end)

magOrder = {
	{'Final Impact', 4, 700},
	{'Impact', 3, 500},
	{'Blast', 1, 200}
}

isExhausted = function(magia)
	local savedTime = storage.exhaustCombo[magia]
	if type(savedTime) ~= 'number' then
		return false
	end
	
	
	if type(os) == 'table' then
		if savedTime <= os.time() then
			return true
		end
	elseif savedTime > now and now - 5000 <= savedTime then
		return true
	end

	storage.exhaustCombo[magia] = nil
	return false
end

setExhaust = function(magia, total)
	if type(os) == 'table' then
		storage.exhaustCombo[magia] = os.time() + total
	else
		storage.exhaustCombo[magia] = now + (total * 1000) - 250
	end
	return true
end

formattedSpell = function(spell)
	spell = actualVocation .. ' ' .. spell
	return spell:lower():trim()
end


macro(100, "Combo", function()
	local playerLevel = player:getLevel()
	if actualVocation then
		if g_game.isAttacking() then
			for _, magConfig in ipairs(magOrder) do
				if playerLevel > magConfig[3] then
					local formattedSpell = formattedSpell(magConfig[1])
					if not isExhausted(formattedSpell) then
						return say(formattedSpell)
					end
				end
			end	
		end
	else
		return g_game.look(player)
	end
end, toolsTab)

storage.exhaustCombo = storage.exhaustCombo or {}

onTalk(function(name, level, mode, text, channelId, pos)
	if actualVocation then
		if player:getName() == name then
			text = text:lower()
			for _, magConfig in ipairs(magOrder) do
				local formattedSpell = formattedSpell(magConfig[1])
				if text == formattedSpell then
					setExhaust(formattedSpell, magConfig[2])
					break
				end
			end
		end
	end
end)

local regexLook = [[You see yourself. You are ([a-z 'A-z- '0-9]*).]]
local removeFromLook = {' Reborn', ' Super Alternative', ' Alternative'}

onTextMessage(function(mode, text)
	if not actualVocation then
		local regexMatch = regexMatch(text, regexLook)
		if #regexMatch > 0 then
			actualVocation = regexMatch[1][2]
			for _, value in ipairs(removeFromLook) do
				actualVocation = actualVocation:gsub(value, '')
			end
			actualVocation = actualVocation:trim()
			if actualVocation:lower() == 'black goku' then
				actualVocation = 'Goku Black'
			end
			talkPrivate(player:getName(), 'Você é um ' .. actualVocation .. ', seu combo já foi automaticamente definido.')
		end
	end
end)

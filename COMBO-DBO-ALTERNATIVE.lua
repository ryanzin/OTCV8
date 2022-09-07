magOrder = {
	{'Final Impact', 4, 700},
	{'Impact', 3, 500},
	{'Blast', 1, 200}
}

formattedSpell = function(spell)
	local spell = actualVocation .. ' ' .. spell
	return spell:lower():trim()
end


macro(100, "Combo", function()
	local playerLevel = player:getLevel()
	if actualVocation then
		if g_game.isAttacking() then
			for _, magConfig in ipairs(magOrder) do
				if playerLevel > magConfig[3] then
					local formattedSpell = formattedSpell(magConfig[1])
					local checkExhaust = storage.exhaustCombo[formattedSpell]
					if not checkExhaust or checkExhaust <= os.time() then
						return say(formattedSpell)
					end
				end
			end	
		end
	else
		return g_game.look(player)
	end
end)

storage.exhaustCombo = storage.exhaustCombo or {}

onTalk(function(name, level, mode, text, channelId, pos)
	if actualVocation then
		if player:getName() == name then
			text = text:lower()
			for _, magConfig in ipairs(magOrder) do
				local formattedSpell = formattedSpell(magConfig[1])
				if text == formattedSpell then
					storage.exhaustCombo[formattedSpell] = os.time() + magConfig[2]
					break
				end
			end
		end
	end
end)

local regexLook = [[You see yourself. You are ([a-z 'A-z- '0-9]*).]]
local removeFromLook = {' Reborn', ' Super Alternative', ' Alternative'}

onTextMessage(function(mode, text)
	if not actualVocation
		local regexMatch = regexMatch(text, regexLook)
		if #regexMatch > 0 then
			actualVocation = regexMatch[1][2]
			for _, text in ipairs(removeFromLook) do
				actualVocation = actualVocation:gsub(text, '')
			end
			if actualVocation:lower() == 'black goku' then
				actualVocation = 'Goku Black'
			end
			talkPrivate(player:getName(), 'Você é um ' .. actualVocation .. ', seu combo já foi automaticamente definido.')
		end
	end
end)

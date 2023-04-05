setDefaultTab('Tools')


UI.Label('Combo:')
addTextEdit("Magias", storage.comboSpells or "magia1, magia2, magia3", function(widget, text)
	storage.comboSpells = text
end)


UI.Label('Area:')
addTextEdit("Area", storage.areaSpell or "Magia de Area", function(widget, text)
	storage.areaSpell = text
end)

if g_game.getWorldName() == 'Katon' then -- FIX NTO SPLIT
	function getSpecs()
		local specs = {}
		for _, tile in pairs(g_map.getTiles(posz())) do
			for _, thing in pairs(tile:getThings()) do
				if thing:isCreature() then
					table.insert(specs, thing)
				end
			end
		end
		return specs
	end
end

local timeArea = 0
macro(1, "Anti-Red", function()
	local pos = pos()
	local monstersCount = 0
	timeArea = player:getSkull() >= 3 and now + 30000 or timeArea
	local specs = getSpecs and getSpecs() or getSpectators(true)
	for i = 1, #specs do
		local spec = specs[i]
		if timeArea > now then break end
		local specPos = spec:getPosition()
		local checkPosz = math.abs(specPos.z - pos.z)
		if checkPosz <= 3 then
			if (spec ~= player and spec:isPlayer() and spec:getEmblem() ~= 1 and spec:getShield() < 3) then
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
	if not g_game.isAttacking() then return end
   	for _, spell in ipairs(storage.comboSpells:split(',')) do
		say(spell)
	end
end)

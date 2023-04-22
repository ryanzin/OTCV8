UI.Label('Combo:')
addTextEdit("Magias", storage.comboSpells or "magia1, magia2, magia3", function(widget, text)
	storage.comboSpells = text;
end)


UI.Label('Area:')
addTextEdit("Area", storage.areaSpell or "Magia de Area", function(widget, text)
	storage.areaSpell = text;
end)

if (not getSpectators or #getSpectators(true) == 0) then
	function getSpectators()
		local specs = {};
		local tiles = g_map.getTiles(posz());
		for i = 1, #tiles do
			local tile = tiles[i];
			local creatures = tile:getCreatures();
			if (#creatures > 0) then
				table.insert(specs, creatures);
			end
		end
		return specs;
	end
end

local timeArea = 0;
macro(1, "Anti-Red", function()
	local pos = pos();
	local monstersCount = 0;
	timeArea = player:getSkull() >= 3 and now + 30000 or timeArea;
	local specs = getSpectators(true);
	for i = 1, #specs do
		local spec = specs[i];
		if (timeArea > now) then break; end
		local specPos = spec:getPosition();
		local floorDiff = math.abs(specPos.z - pos.z);
		if (floorDiff > 3) then
			goto continue;
		end
		if (spec ~= player and spec:isPlayer() and spec:getEmblem() ~= 1 and spec:getShield() < 3) then
			timeArea = now + 30000;
			break
		elseif (floorDiff == 0 and spec:isMonster() and getDistanceBetween(specPos, pos) == 1) then
			monstersCount = monstersCount + 1;
		end
		::continue::
	end
	if monstersCount > 1 and (not timeArea or timeArea < now) then
		return say(storage.areaSpell);
	end
	if (not g_game.isAttacking()) then return; end
   	for _, spell in ipairs(storage.comboSpells:split(',')) do
		say(spell);
	end
end)

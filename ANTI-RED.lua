UI.Label('Combo:')

storage.widgetPos = storage.widgetPos or {};

local antiRedTimeWidget = setupUI([[
UIWidget
  background-color: black
  opacity: 0.8
  padding: 0 5
  focusable: true
  phantom: false
  draggable: true
]], g_ui.getRootWidget())


antiRedTimeWidget.onDragEnter = function(widget, mousePos)
	if (not modules.corelib.g_keyboard.isCtrlPressed()) then return; end
	widget:breakAnchors();
	local widgetPos = widget:getPosition();
	widget.movingReference = {x = mousePos.x - widgetPos.x, y = mousePos.y - widgetPos.y};
	return true;
end

antiRedTimeWidget.onDragMove = function(widget, mousePos, moved)
	local parentRect = widget:getParent():getRect();
	local x = math.min(math.max(parentRect.x, mousePos.x - widget.movingReference.x), parentRect.x + parentRect.width - widget:getWidth());
	local y = math.min(math.max(parentRect.y - widget:getParent():getMarginTop(), mousePos.y - widget.movingReference.y), parentRect.y + parentRect.height - widget:getHeight());   
	widget:move(x, y);
	storage.widgetPos.antiRedTime = {x = x, y = y};
	return true
end

local name = "antiRedTime";
storage.widgetPos[name] = storage.widgetPos[name] or {};
antiRedTimeWidget:setPosition({x = storage.widgetPos[name].x or 50, y = storage.widgetPos[name].y or 50});



local refreshSpells = function()
	castingSpells = {};
	if (storage.comboSpells) then
		local split = storage.comboSpells:split(",");
		for _, spell in ipairs(split) do
			table.insert(castingSpells, spell:trim());
		end
	end
end


addTextEdit("Magias", storage.comboSpells or "magia1, magia2, magia3", function(widget, text)
	storage.comboSpells = text;
	refreshSpells();
end)

refreshSpells();


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

if (not storage.antiRedTime or storage.antiRedTime - 30000 > now) then
	storage.antiRedTime = 0;
end


local addAntiRedTime = function()
	storage.antiRedTime = now + 30000;
end

local toInteger = function(t)
	t = tostring(t);
	t = t:split(".");
	return tonumber(t[1]);
end

macro(1, "Anti-Red", function()
	local pos, monstersCount = pos(), 0;
	if (storage.antiRedTime >= now) then
		antiRedTimeWidget:show();
		local diff = storage.antiRedTime - now;
		diff = diff / 1000;
		antiRedTimeWidget:setText(tr("AREA BLOCKED FOR %d SECONDS.", toInteger(diff)));
	else
		antiRedTimeWidget:hide();
	end
	if (player:getSkull() >= 3) then
		addAntiRedTime();
	end
	local specs = getSpectators(true);
	for _, spec in ipairs(specs) do
		local specPos = spec:getPosition();
		local floorDiff = math.abs(specPos.z - pos.z);
		if (floorDiff > 3) then goto continue; end
		if (spec ~= player and spec:isPlayer() and spec:getEmblem() ~= 1 and spec:getShield() < 3) then
			addAntiRedTime();
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
   	for _, spell in ipairs(castingSpells) do
		say(spell);
	end
end)

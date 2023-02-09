local timeTrack = {
	['ntoultimate'] = 15,
	['ntolost'] = 5,
	['katon'] = 5, -- NTO SPLIT
	['dbolost'] = 2
}

local pzTime = timeTrack[g_game.getWorldName():lower()] or 15
	

local os = os or modules.os

if type(storage.battleTracking) ~= 'table' or storage.battleTracking[2] ~= player:getId() or (not os and storage.battleTracking[1] - now > pzTime * 60 * 1000) then
    storage.battleTracking = {0, player:getId(), {}}
end 

onTextMessage(function(mode, text)
	text = text:lower()
	if text:find("o assassinato de") or text:find("was not justified") or text:find("o assassinato do")then
		storage.battleTracking[1] = not os and now + (pzTime * 60 * 1000) or os.time() + (pzTime * 60)
		return
	end
	if not text:find("due to your") and not text:find("you deal") then return end
	for _, spec in ipairs(getSpectators()) do
		local specName = spec:getName():lower()
		if spec:isPlayer() and text:find(specName) then
			storage.battleTracking[3][specName] = {timeBattle = not os and now + 60000 or os.time() + 60, playerId = spec:getId()}
			return
		end
	end
end)

math.mod = math.mod or function(base, modulus)
	return base % modulus
end

local function doFormatMin(v)
    v = v > 1000 and v / 1000 or v
    local mins = 00
    if v >= 60 then
        mins = string.format("%02.f", math.floor(v / 60))
    end
    local seconds = string.format("%02.f", math.abs(math.floor(math.mod(v, 60))))
    return mins .. ":" .. seconds
end




storage.widgetPos = storage.widgetPos or {}

local pkTimeWidget = setupUI([[
UIWidget
  background-color: black
  opacity: 0.8
  padding: 0 5
  focusable: true
  phantom: false
  draggable: true
]], g_ui.getRootWidget())


pkTimeWidget.onDragEnter = function(widget, mousePos)
	if not modules.corelib.g_keyboard.isCtrlPressed() then
		return false
	end
	widget:breakAnchors()
	widget.movingReference = { x = mousePos.x - widget:getX(), y = mousePos.y - widget:getY() }
	return true
end

pkTimeWidget.onDragMove = function(widget, mousePos, moved)
	local parentRect = widget:getParent():getRect()
	local x = math.min(math.max(parentRect.x, mousePos.x - widget.movingReference.x), parentRect.x + parentRect.width - widget:getWidth())
	local y = math.min(math.max(parentRect.y - widget:getParent():getMarginTop(), mousePos.y - widget.movingReference.y), parentRect.y + parentRect.height - widget:getHeight())        
	widget:move(x, y)
	return true
end

pkTimeWidget.onDragLeave = function(widget, pos)
	storage.widgetPos['pkTimeWidget'].x = widget:getX()
	storage.widgetPos['pkTimeWidget'].y = widget:getY()
	return true
end

local name = "pkTimeWidget"
storage.widgetPos[name] = storage.widgetPos[name] or {}
pkTimeWidget:setPosition({x = storage.widgetPos[name].x or 50, y = storage.widgetPos[name].y or 50})



if g_game.getWorldName() == 'Katon' then -- FIX NTO SPLIT
	function getSpectators()
		local specs = {}
		for _, tile in pairs(g_map.getTiles(posz())) do
			for _, thing in pairs(tile:getThings()) do
				local status, name = pcall(function() return thing:getName() end)
				if status and name and #name > 0 then
					table.insert(specs, thing)
				end
			end
		end
		return specs
	end
	function getPlayerByName(name)
		name = name:lower():trim()
		for _, spec in ipairs(getSpectators()) do
			if spec:getName():lower() == name then
				return spec
			end
		end
	end
end

pkTimeMacro = macro(1, function()
	local time = os and os.time() or now
	if isInPz() then storage.battleTracking[1] = 0 end
	for specName, value in pairs(storage.battleTracking[3]) do
		if (os and value.timeBattle >= time) or (not os and value.timeBattle >= time and value.timeBattle - 60000 <= time) then
			local playerSearch = getPlayerByName(specName, true)
			if playerSearch then
				if playerSearch:getId() == value.playerId then
					if playerSearch:getHealthPercent() == 0 then
						storage.battleTracking[1] = not os and time + (pzTime * 60 * 1000) or time + (pzTime * 60)
						storage.battleTracking[3][specName] = nil
					end
				else
					storage.battleTracking[3][specName] = nil
				end
			end
		else
			storage.battleTracking[3][specName] = nil
		end
	end
	local widgetTime = pkTimeWidget
	if storage.battleTracking[1] < time then
		widgetTime:setText('PK Time is: 00:00')
		widgetTime:setColor('green')
	else
		widgetTime:setText('PK Time is: ' .. doFormatMin(storage.battleTracking[1] - time))
		widgetTime:setColor("red")
	end
end)

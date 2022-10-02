local TempoPK = 15 -- tempo em minutos

storage.tablePZ = type(storage.tablePZ) == 'table' and storage.tablePZ[1] - now <= 60000 and storage.tablePZ[2] == player:getId() and storage.tablePZ or {0, player:getId(), {}}

onTextMessage(function(mode, text)
    text = text:lower()
    if text:find('o assassinato de') or text:find('was not justified') then
        storage.TimeRemain = now + (TempoPK * 60 * 1000)
		return
    end
    if not text:find('due to your') and not text:lower():find('you deal') then return end
    for _, spec in ipairs(getSpectators(posz())) do
        if spec:isPlayer() and text:find(spec:getName()) then
            storage.tablePZ[3][spec:getName()] = {now + 60000, spec:getId())
            return
        end
    end
end)

local function doFormatMin(v)
    if v < 1000 then
        return '00:00'
    end
    v = v/1000
    local mins = 00
    local seconds = 00
    if v >= 60 then
        mins = string.format("%02.f", math.floor(v / 60))
    end
    seconds = string.format("%02.f", math.abs(math.floor(math.mod(v, 60))))
    return mins .. ":" .. seconds
end

local widget = setupUI([[
Panel
  size: 14 14
  height:514
  anchors.bottom: parent.bottom
  anchors.left: parent.left
  opacity: 1
  margin-left: 200
]], g_ui.getRootWidget())

local timepk = g_ui.loadUIFromString([[
Label
  color: white
  background-color: #00000090
  opacity: 0.87
  text-horizontal-auto-resize: true 
]], widget)

macro(100, function()
    for specName, value in pairs(storage.tablePZ[3]]) do
        if value[1] >= now and value[1] - 60000 <= now then
			local findHim = getPlayerByName(specName, true)
            if findHim:getHealthPercent() == 0 then
				if findHim:getId() == value[2] then
					storage.tablePZ[1] = now + (TempoPK * 60 * 1000)
				end
				storage.tablePZ[3][specName] = nil
                end
            end
        else
            storage.tablePZ[3][specName] = nil
        end
    end

    if storage.tablePZ[1] < now then
        timepk:setText('~ Pz Locked: 00:00')
        timepk:setColor('#EBDAA2')
    else
        timepk:setText(doFormatMin(math.abs(now - storage.tablePZ[1])))
        timepk:setColor('#ff6666')
    end
end)

local pzTime = 15 -- tempo em minutos


if type(storage.battleTracking) ~= 'table' or storage.battleTracking[2] ~= player:getId() or storage.battleTracking[1] - now > pzTime * 60 * 1000 then
    storage.battleTracking = {
        0,
        player:getId(),
        {}
    }
end
    
    

onTextMessage(function(mode, text)
    text = text:lower()
    if text:find("o assassinato de") or text:find("was not justified") then
        storage.battleTracking[1] = now + (pzTime * 60 * 1000)
        return
    end
    if not text:find("due to your") and not text:find("you deal") then return end
    for _, spec in pairs(getSpectators()) do
        local specName = spec:getName():lower()
        if spec:isPlayer() and text:find(specName) then
            storage.battleTracking[3][specName] = {
                now + 60000,
                spec:getId()
            }
            return
        end
    end
end)

local function doFormatMin(v)
    if v < 1000 then
        return "00:00"
    end
    v = v / 1000
    local mins = 00
    local seconds = 00
    if v >= 60 then
        mins = string.format("%02.f", math.floor(v / 60))
    end
    seconds = string.format("%02.f", math.abs(math.floor(math.mod(v, 60))))
    return mins .. ":" .. seconds
end


local spellsWidgets = spellsWidgets or {}

storage.widgetPositions = storage.widgetPositions or {}

spellsWidgets['pkTime'] = setupUI([[
UIWidget
  background-color: black
  opacity: 0.8
  padding: 0 5
  focusable: true
  phantom: false
  draggable: true
]], g_ui.getRootWidget())


local function attachSpellWidgetCallbacks(key) -- credits to VictorNeox#4112, minor changes were made.
    spellsWidgets[key].onDragEnter = function(widget, mousePos)
        if not modules.corelib.g_keyboard.isCtrlPressed() then
            return false
        end
        widget:breakAnchors()
        widget.movingReference = { x = mousePos.x - widget:getX(), y = mousePos.y - widget:getY() }
        return true
    end
  
    spellsWidgets[key].onDragMove = function(widget, mousePos, moved)
        local parentRect = widget:getParent():getRect()
        local x = math.min(math.max(parentRect.x, mousePos.x - widget.movingReference.x), parentRect.x + parentRect.width - widget:getWidth())
        local y = math.min(math.max(parentRect.y - widget:getParent():getMarginTop(), mousePos.y - widget.movingReference.y), parentRect.y + parentRect.height - widget:getHeight())        
        widget:move(x, y)
        return true
    end
  
    spellsWidgets[key].onDragLeave = function(widget, pos)
        storage.widgetPositions[key].x = widget:getX()
        storage.widgetPositions[key].y = widget:getY()
        return true
    end
end

for name, _ in pairs(spellsWidgets) do
    storage.widgetPositions[name] = storage.widgetPositions[name] or {}
	spellsWidgets[name]:setPosition(
		{
			storage.widgetPositions[name] or {
				x = 0,
				y = 0
			}
		}
	)
    attachSpellWidgetCallbacks(name)
end

macro(100, function()

    for specName, value in pairs(storage.battleTracking[3]) do
        if value[1] >= now and value[1] - 60000 <= now then
            local playerSearch = getCreatureById(specName, true)
            if playerSearch then
                if playerSearch:getId() == value[2] then
                    if playerSearch:getHealthPercent() == 0 then
                        storage.battleTracking[1] = now + (pzTime * 60 * 1000)
                        storage.battleTracking[3][specName] = nil
                    end
                else
                    battleTrcking[3][specName] = nil
                end
            end
        else
            battleTrcking[3][specName] = nil
		end
	end
    if storage.battleTracking[1] < now then
        spellsWidgets['pkTime']:hide()
    else
        spellsWidgets['pkTime']:setText('PK Time is: ' ..
            doFormatMin(
                math.abs(now - storage.battleTracking[1])
            )
        )
        spellsWidgets['pkTime']:setColor("red")
    end
end)

local tab = addTab('Combo')

local comboConfig = {}

comboConfig.times = {
	['canudo'] = 6,
	['impact'] = 1,
	['umTiro'] = 2,
	['fast'] = 2
}

if type(storage.exhaustCombo) ~= 'table' then
	storage.exhaustCombo = {}
end

comboConfig.vocations = {
	['Goku'] = {
		['canudo'] = 'Chou Kamehameha',
		['impact'] = 'Dragon Fist Attack',
		['umTiro'] = 'Super Ryuken',
		['fast'] = 'Genki Renzoku'
	},
	
	['Gogeta'] = {
		['canudo'] = 'Chou Kamehameha',
		['impact'] = 'Dragon Fist Attack',
		['umTiro'] = 'Super Ryuken', 
		['fast'] = 'Genki Renzoku'
	},
	
	['Vegeta'] = {
		['canudo'] = 'Chou Kamehameha',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'Extinct Attack',
		['fast'] = 'Saiyajin Blast',
	},
	
	['Piccolo'] = {
		['canudo'] = 'Chybie Makankosappo',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'Hellzone Granade',
		['fast'] = 'Hell Granade'
	},
	
	['C17'] = {
		['canudo'] = 'Mystic Cannon',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'Mega Bomb',
		['fast'] = 'Deadly Bomb'
	},
	
	['Gohan'] = {
		['canudo'] = 'Ultra Masenko',
		['inpact'] = 'Combo Impact',
		['umTiro'] = 'Massive Sword Attack',
		['fast'] = 'Great Saiyaman Attack'
	},
	
	['Trunks'] = {
		['canudo'] = 'Ultra Finish Buster',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'Massive Sword Attack',
		['fast'] = 'Saiyajin Blast'
	},
	
	['Cell'] = {
		['canudo'] = 'Chou Kamehameha',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'Mega Bomb',
		['fast'] = 'Hell Granade'
	},
	
	['Freeza'] = {
		['canudo'] = 'Ultra Dead Flash',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'Evil Kienzan',
		['fast'] = 'Nova Blast'
	},
	
	['Golden Freeza'] = {
		['canudo'] = 'Ultra Dead Flash',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'Evil Kienzan',
		['fast'] = 'Nova Blast'
	},
	
	['Majin Boo'] = {
		['canudo'] = 'Boo Kamehameha',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'Extinct Attack',
		['fast'] = 'Boo Pink Ball'
	},
	
	['Broly'] = {
		['canudo'] = 'Barakuitsu Chou',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'Meteor Bash',
		['fast'] = 'Barakuitsu Blast'
	},
	
	
	['C18'] = {
		['canudo'] = 'Mystic Cannon',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'Evil Kienzan',
		['fast'] = 'Deadly Bomb'
	},
	
	['Uub'] = {
		['canudo'] = 'Ultra Mystic Flash',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'Extinct Attack',
		['fast'] = 'Pink Ball'
	},
	
	['Goten'] = {
		['canudo'] = 'Ghost Blaster',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'Kamikaze Explosion',
		['fast'] = 'Chybie Blast'
	},
	
	['Chibi Trunks'] = {
		['canudo'] = 'Ghost Blaster',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'Kamikaze Explosion',
		['fast'] = 'Chybie Blast'
	},
		
	['Cooler'] = {
		['canudo'] = 'Ultra Dead Flash',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'Nova',
		['fast'] = 'Nova Blast'
	},
			
	['Dende'] = {
		['canudo'] = 'Chou Kamehameha',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'Hellzone Granade',
		['fast'] = 'Namekjin Wave'
	},
				
	['Tsuful'] = {
		['canudo'] = 'Ultra Dead Flash',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'Final Shine',
		['fast'] = 'Ultimate Shine'
	},
					
	['Bardock'] = {
		['canudo'] = 'Chou Kamehameha',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'Final Shine',
		['fast'] = 'Soudou Yari'
	},
	
	['Broodock'] = {
		['canudo'] = 'Chou Kamehameha',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'Meteor Bash',
		['fast'] = 'Barakuitsu Blast'
	},
		
	['Kuririn'] = {
		['canudo'] = 'Chou Kamehameha',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'Evil Kienzan',
		['fast'] = 'Super Kienzan Blast'
	},
			
	['Kaioshin'] = {
		['canudo'] = 'Chou Kamehameha',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'Extinct Attack',
		['fast'] = 'Supreme Blast'
	},
				
	['Janemba'] = {
		['canudo'] = 'Super Satan Cannon',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'Demon Blast',
		['fast'] = 'Sword Throw'
	},
					
	['Raditz'] = {
		['canudo'] = 'Saiyan Kamehameha',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'Calamity Blaster',
		['fast'] = 'Chou Makosen'
	},
						
	['Turles'] = {
		['canudo'] = 'Saiyan Kamehameha',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'Calamity Blaster',
		['fast'] = 'Chou Makosen'
	},
							
	['Bulma'] = {
		['canudo'] = 'Ultra Final Flash',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'Final Shine',
		['fast'] = 'Mystic Bash'
	},
								
	['Shenron'] = {
		['canudo'] = 'Final Hell Cannon',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'Omega Cannon',
		['fast'] = 'Negative Karma Ball'
	},
								
	['Vegetto'] = {
		['canudo'] = 'Ultra Final Flash',
		['impact'] = 'Dragon Fist Attack',
		['umTiro'] = 'Guided Scatter Shot',
		['fast'] = 'Renzoku Kikouha'
	},
									
	['Tapion'] = {
		['canudo'] = 'Ultra Dead Flash',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'Brave Cannon',
		['fast'] = 'Brave Sword Attack'
	},
										
	['Kame'] = {
		['canudo'] = 'Chou Kamehameha',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'Roshi Attack',
		['fast'] = 'Turtle Devastation'
	},
											
	['King Vegeta'] = {
		['canudo'] = 'Death Cannon',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'Infernal Punch',
		['fast'] = 'Infernal Rage'
	},
												
	['Zaiko'] = {
		['canudo'] = 'Saiko Chou',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'Saikosai Hakai',
		['fast'] = 'Saikosai Boru'
	},
													
	['Chilled'] = {
		['canudo'] = 'Death Razor',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'Concentrate Razor',
		['fast'] = 'Ruthless Blow'
	},
														
	['Goku Black'] = {
		['canudo'] = 'Chou Kamehameha',
		['impact'] = 'Dragon Fist Attack',
		['umTiro'] = 'Super Ryuken',
		['fast'] = 'Genki Renzoku'
	},
	
	['Goku Black Evo'] = {
		['canudo'] = 'Chou Kamehameha',
		['impact'] = 'Dragon Fist Attack',
		['umTiro'] = 'Super Ryuken',
		['fast'] = 'Genki Renzoku'
	},
	
	['Bills Evolution'] = {
		['canudo'] = 'Ultra Mystic Flash',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'Oblivion Ball',
		['fast'] = 'Genki Renzoku'
	},
		
	['Black Zamasu'] = {
		['canudo'] = 'Ultra Mystic Flash',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'Omega Cannon',
		['fast'] = 'Rose Ball'
	},
			
	['Whiss'] = {
		['canudo'] = 'Ultra Mystic Flash',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'Blue Razor',
		['fast'] = 'Rose Ball'
	},
				
	['Vegetto Black'] = {
		['canudo'] = 'Ultra Final Flash',
		['impact'] = 'Dragon Fist Attack',
		['umTiro'] = 'Guided Scatter Shot',
		['fast'] = 'Renzoku Kikouha'
	},
					
	['Gogeta Blue'] = {
		['canudo'] = 'Chou Kamehameha',
		['impact'] = 'Dragon Fist Attack',
		['umTiro'] = 'Super Ryuken',
		['fast'] = 'Genki Renzoku'
	},
						
	['Vegetto Blue'] = {
		['canudo'] = 'Chou Kamehameha',
		['impact'] = 'Dragon Fist Attack',
		['umTiro'] = 'Final Ryuken Rage',
		['fast'] = 'Genki Renzoku'
	},
							
	['Champa'] = {
		['canudo'] = 'Domhouha Chou',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'God Blast',
		['fast'] = 'Ruthless Ball'
	},
								
	['Kyabe'] = {
		['canudo'] = 'Ultra Final Flash',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'Survivor Saiyan',
		['fast'] = 'Saiyan Force'
	},
									
	['Frost'] = {
		['canudo'] = 'Death Cannon',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'Deadly Sting',
		['fast'] = 'Frozen Buster'
	},
										
	['Vermouth'] = {
		['canudo'] = 'Burn Wazer',
		['impact'] = 'Combo Impact',
		['umTiro'] = 'The Belmod',
		['fast'] = 'Crazzy Monsterkill'
	},
											
	['Goku Limit Break'] = {
		['canudo'] = 'Chou Kamehameha',
		['impact'] = 'Dragon Fist Attack',
		['umTiro'] = 'Super Ryuken',
		['fast'] = 'Genki Renzoku'
	},
}





comboConfig.toOrder = function(t)
	return {t['canudo'], t['fast'], t['umTiro'], t['impact']}
end

ucwords = function(text)
	text = text:trim():split(' ')
	local texto
	for index, value in ipairs(text) do
		value = value:sub(1, 1):upper() .. value:sub(2)
		texto = texto and texto .. ' ' .. value or value
	end
	
	return texto
end

for vocation, spells in pairs(comboConfig.vocations) do
	comboConfig.vocations[ucwords(vocation)] = spells
end

comboConfig.setupMacro = macro(1, function()
	return comboConfig.actualVocation and comboConfig.setupMacro.setOff() or g_game.look(player)
end)

comboConfig.isExhausted = function(n)
	return type(n) == 'number' and n > os.time()
end

comboConfig.macroCombo = macro(1, 'Combo', function()
	for i = 1, 5 do
		if modules.corelib.g_keyboard.isKeyPressed('F' .. i) then
			return
		end
	end
	if not comboConfig.actualVocation or not g_game.isAttacking() then
		return
	end
	local spells = comboConfig.actualCombo
	for _, spell in ipairs(comboConfig.toOrder(spells)) do
		if not comboConfig.isExhausted(spell) then
			say(spell)
		end
	end
end, tab)

onTalk(function(name, level, mode, text)
	if not comboConfig.actualVocation then return end
		
	if name ~= player:getName() then return end
	
	if mode ~= 44 then return end
	
	text = text:lower()
	
	local spells = comboConfig.actualCombo
	for key, value in pairs(spells) do
		local convertValue = value:lower():trim()
		if convertValue == text then
			storage.exhaustCombo[convertValue] = os.time() + comboConfig.times[key]
			break
		end
	end
end)

vocationVerify = onTextMessage(function(mode, text)
	text = text:lower()
	if text:find('you see yourself') then
		local regex = [[you see yourself. you are ([\w ]*).]]
		local checkFind = regexMatch(text, regex)
		if #checkFind > 0 then
			local stringCheck = checkFind[1][2]:split(' ')
			local actualVoc
			for _, texto in ipairs(stringCheck) do
				if texto == 'reborn' or texto == 'ultra' then
					break
				end
				actualVoc = actualVoc and actualVoc .. ' ' .. texto or texto
			end
			comboConfig.actualVocation = ucwords(actualVoc)
			comboConfig.actualCombo = comboConfig.vocations[comboConfig.actualVocation]
			talkPrivate(player:getName(), 'Combo Definido, ' .. comboConfig.actualVocation .. '.')
			vocationVerify.remove()
		end
	end
end)

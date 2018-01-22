-- Z3-Rando-Hud-BizHawk.lua - snes9x Version
-- Version 4 "Helmasaur King"
require 'Z3-Rando-Hud-Addresses'

function memory.read_u8(target)
	return memory.readbyte(target + 0x7E0000)
end

function memory.read_u16_le(target)
	return memory.readword(target + 0x7E0000)
end

function bizstring.hex(value)
	j = string.format('%X',value)
	return j
end

game_clear = false

function race()
	q = memory.readbyte(0x00FFC3)
	if (q == 0x54) then
		return true
	else
		return false
	end
end

function initScript()
	math.randomseed(os.time())

	console.clear()
	print("Script initialized.")
end

function getCurrentRoomByID()
	f = memory.read_u16_le(OWUW_indic)
	i = memory.read_u16_le(room_Index)
	j = memory.read_u16_le(ow_loc_dex)
	here = ""
	if (j == 0x88) then
		here = "VICTORY!"
		game_clear = true		
	elseif (f == 0xFFFF) then
		here = getOverworldLocationByID(i, j)
	else
		here = getUnderworldLocationByID(i, j)
	end
	gui.text(3,3,here)
end

function getOverworldLocationByID(i, j)
	if j > 0x81 then
		return bizstring.hex(j) .. ": Overworld Location Not Yet Indexed"
	else
		return OverworldList[j]
	end
end

function getUnderworldLocationByID(i, j)
	lamp = memory.read_u8(0xF34A)
	if i > 0x128 then
		return bizstring.hex(i) .. ": Underworld Location Not Yet Indexed"
	elseif lamp > 0 then
		return UnderworldList[i].name
	else
		if UnderworldList[i].dark == false then
			return UnderworldList[i].name
		else
			return "???"
		end
	end
end

function mainLoop()
	while true do
		emu.frameadvance()
		
		if game_clear == true then
			gui.text(3,3,"You beat the game!")
		elseif game_clear == false then
			getCurrentRoomByID()
		else
			gui.text(3,3,"Boolean game_clear neither true nor false..?")
		end
	end
end

if not race() then	
	initScript()
	mainLoop()
else
	print("")
	print("Detected a race rom.") 
	print("Auto-huds like this one are disallowed during races.")
	print("Did you create a race rom by mistake?")
end
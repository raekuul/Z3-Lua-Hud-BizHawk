-- Z3-Rando-Hud-BizHawk.lua - BizHawk Version
-- Version 4 "King Helmasaur"
require 'Z3-Rando-Hud-Addresses'

modes = {[0]="none","keysanity","dungeonItems"}
active_mode = "none"
seed = ""
game_clear = false

function readAsAscii(address, length, domain)
	ret = ""
	q = memory.readbyterange(address, length, domain)
	for i=0,length-1 do
	  ret = ret .. string.char(q[i])
	end
	return ret	
end

function setMode(mode)
	active_mode = mode
	updateItemGrid()
end

controls = forms.newform(160,144, "Zelda 3 Autohud Controls")
dungeonItemsMode = forms.button(controls, "Dungeon Items", function() setMode("dungeonItems") end, 5, 75)
keysanityMode = forms.button(controls, "Key Counts", function() setMode("keysanity") end, 5, 40)
emptyMode = forms.button(controls, "Default", function() setMode("none") end, 5, 5)

function race()
	q = readAsAscii(0x00FFC3, 0x7, "System Bus")
	if (q == "TOURNEY") then
		return true
	else
		seed = readAsAscii(0x00FFC2, 0xA, "System Bus")
		return false
	end
end

function initScript()
	math.randomseed(os.time())

	console.clear()
	print("Script initialized.")

	res = [[.\images\res\]]
	blank = [[blank.png]]

	memory.usememorydomain("WRAM")

	menuWasOpened = false

	drawSpace = gui.createcanvas(256,224)
	drawSpace.Clear(0xff000000)
	
	console.log("Controls dialog has been assigned handle "..controls)
	client.SetClientExtraPadding(0,20,0,20)
	client.displaymessages(true)
end

function drawArray(array)
	w = 32
	h = 32
	row = 0
	column = 0
	drawSpace.Clear(0xff000000)
	for k, v in pairs(array) do
		if column > 4 then
			column = 0
			row = row + 1
		end
	q = memory.read_u8(array[k].address)
	drawSpace.DrawImage(array[k][q],w*array[k].col,h*array[k].row)
	column = column + 1
	end
end

function setMUFlag()
end

function updatePendants()
	p = {values={[0] = 0, 0, 0},paths={[0]=res.."pendantR.png",res.."pendantB.png",res.."pendantG.png"}}
	for r=0,2,1 do
		p.values[r] = bit.check(memory.read_u8(pendants.address),r)
		if p.values[r] == false then
			drawSpace.DrawImage(res .. "pendantX.png",32*pendants.col,32*(pendants.poss[r] - 1))
		else
			drawSpace.DrawImage(p.paths[r],32*pendants.col,32*(pendants.poss[r] - 1))
		end
	end
end

function updateCrystals()
	p = {values={[0] = 0, 0, 0, 0, 0, 0, 0, 0}}
	j = memory.read_u8(crystals.address)
	
	for r=0,7,1 do
		p.values[r] = bit.check(j,r)
		if p.values[r] == false then
			drawSpace.DrawImage(res .. "crystalX.png",32*crystals.col,32*(crystals.poss[r] - 1))
		else
			drawSpace.DrawImage(res .. "crystal"..crystals.poss[r]..".png",32*crystals.col,32*(crystals.poss[r] - 1))
		end
	end
end

function updateHeartPieces()
	q = memory.read_u8(heartPiece.address)
	drawSpace.DrawImage(heartPiece[q],32*heartPiece.col,32*heartPiece.row)
end

function updateQuiver()
	q = memory.read_u8(quiver.address)
	r = q + 30
	path = [[.\images\quiver\]] .. r .. [[.png]]
	drawSpace.DrawImage(path,32*quiver.col,32*quiver.row)
end

function updateBottles()
	q = { }
	paths = { }
	for r=0,3,1 do
		q[r] = memory.read_u8(0xf35c + r)
		paths[r] = [[.\images\bottles\]] .. q[r] .. [[.png]]
		drawSpace.DrawImage(paths[r],32*r,32*bottle.row)
	end
end

function updateBombBag()
	q = memory.read_u8(bomb_bag.address)
	r = q + 10
	path = [[.\images\bomb_bag\]] .. r .. [[.png]]
	drawSpace.DrawImage(path,32*bomb_bag.col,32*bomb_bag.row)
end

function updateLWBs()
	p={values={[0] = 0, 0, 0}}
	for i=0,2,1 do
		j = boss_root_addr + (lwbosses.offsets[i] * 2)
		p.values[i] = bit.check(memory.read_u8(j),boss_checkBit)
		if p.values[i] == false then
			drawSpace.DrawImage([[.\images\bosses\alive\]] .. lwbosses.img[i] .. ".png",32*lwbosses.col,32*(lwbosses.row + i))
		else
			drawSpace.DrawImage([[.\images\bosses\dead\]] .. lwbosses.img[i] .. ".png",32*lwbosses.col,32*(lwbosses.row + i))
		end
		
		if (active_mode == "keysanity") then
			q = memory.read_u8(keys[lwbosses.keyDex[i]])
			drawSpace.DrawImage([[.\images\hud\]] .. q ..".png",32*lwbosses.col+16,32*(lwbosses.row + i)+16)
		elseif (active_mode == "dungeonItems") then
			bk = bit.check(memory.read_u8(di_root_addr + lwbosses.compassByte[i]+2),lwbosses.compassBit[i])
			dm = bit.check(memory.read_u8(di_root_addr + lwbosses.compassByte[i]+4),lwbosses.compassBit[i])
			dc = bit.check(memory.read_u8(di_root_addr + lwbosses.compassByte[i]),lwbosses.compassBit[i])
			if (dm == true) then
				drawSpace.DrawImage([[.\images\hud\dm.png]],32*lwbosses.col+0,32*(lwbosses.row + i)+16)
			end
			if (dc == true) then
				drawSpace.DrawImage([[.\images\hud\dc.png]],32*lwbosses.col+8,32*(lwbosses.row + i)+16)
			end
			if (bk == true) then
				drawSpace.DrawImage([[.\images\hud\bk.png]],32*lwbosses.col+16,32*(lwbosses.row + i)+16)
			end
		end
	end
end

function updateDWBs()
	p = {values={[0] = 0, 0, 0, 0, 0, 0, 0}}
	for i=0,6,1 do
		j = boss_root_addr + (dwbosses.offsets[i] * 2)
		p.values[i] = bit.check(memory.read_u8(j),boss_checkBit)
		q = memory.read_u8(keys[dwbosses.keyDex[i]])
		if p.values[i] == false then
			drawSpace.DrawImage([[.\images\bosses\alive\]] .. dwbosses.img[i] .. ".png",32*dwbosses.col,32*(dwbosses.row+i))
		else
			drawSpace.DrawImage([[.\images\bosses\dead\]] .. dwbosses.img[i] .. ".png",32*dwbosses.col,32*(dwbosses.row+i))
		end
		
		if (active_mode == "keysanity") then
			q = memory.read_u8(keys[dwbosses.keyDex[i]])
			drawSpace.DrawImage([[.\images\hud\]] .. q ..".png",32*dwbosses.col+16,32*(dwbosses.row + i)+16)
		elseif (active_mode == "dungeonItems") then
			bk = bit.check(memory.read_u8(di_root_addr + dwbosses.compassByte[i]+2),dwbosses.compassBit[i])
			dm = bit.check(memory.read_u8(di_root_addr + dwbosses.compassByte[i]+4),dwbosses.compassBit[i])
			dc = bit.check(memory.read_u8(di_root_addr + dwbosses.compassByte[i]),dwbosses.compassBit[i])
			if (dm == true) then
				drawSpace.DrawImage([[.\images\hud\dm.png]],32*dwbosses.col+0,32*(dwbosses.row + i)+16)
			end
			if (dc == true) then
				drawSpace.DrawImage([[.\images\hud\dc.png]],32*dwbosses.col+8,32*(dwbosses.row + i)+16)
			end
			if (bk == true) then
				drawSpace.DrawImage([[.\images\hud\bk.png]],32*dwbosses.col+16,32*(dwbosses.row + i)+16)
			end
		end
	end
end

function updateAgaState()
	aga1 = memory.read_u8(aga_state.address[0])
	aga2 = memory.read_u8(aga_state.address[1])
	
	q = memory.read_u8(keys[aga_state.keyDex[0]])
	r = memory.read_u8(keys[aga_state.keyDex[1]])
	
	aga_compassByte = 0xf364
	aga_compassBit = 2
	
	if bit.check(aga1,3) == true then
		if bit.check(aga2,3) == true then
			drawSpace.DrawImage([[.\images\bosses\Aga3.png]], 32*aga_state.col, 32*aga_state.row)
		else
			drawSpace.DrawImage([[.\images\bosses\Aga1.png]], 32*aga_state.col, 32*aga_state.row)
		end
	else
		if bit.check(aga2,3) == true then
			drawSpace.DrawImage([[.\images\bosses\Aga2.png]], 32*aga_state.col, 32*aga_state.row)
		else
			drawSpace.DrawImage([[.\images\bosses\Aga0.png]], 32*aga_state.col, 32*aga_state.row)
		end
	end
	
	if (active_mode == "keysanity") then
		drawSpace.DrawImage([[.\images\hud\]] .. q ..".png",32*aga_state.col,32*(aga_state.row))
		drawSpace.DrawImage([[.\images\hud\]] .. r ..".png",32*aga_state.col+16,32*(aga_state.row)+16)
	elseif (active_mode == "dungeonItems") then
		bk = bit.check(memory.read_u8(aga_compassByte+2),aga_compassBit)
		dm = bit.check(memory.read_u8(aga_compassByte+4),aga_compassBit)
		dc = bit.check(memory.read_u8(aga_compassByte+0),aga_compassBit)
		if (dm == true) then
			drawSpace.DrawImage([[.\images\hud\dm.png]],32*aga_state.col+0,32*(aga_state.row)+16)
		end
		if (dc == true) then
			drawSpace.DrawImage([[.\images\hud\dc.png]],32*aga_state.col+8,32*(aga_state.row)+16)
		end
		if (bk == true) then
			drawSpace.DrawImage([[.\images\hud\bk.png]],32*aga_state.col+16,32*(aga_state.row)+16)
		end
	end
end

function updateEscape()
	q = memory.read_u8(keys[0]) + memory.read_u8(keys[1])
	r = memory.read_u8(0xF3C6)
	if bit.check(r,2) == true then
		drawSpace.DrawImage([[.\images\bosses\Zelda.png]],(32*5),(32*3))
	else
		drawSpace.DrawImage([[.\images\bosses\Zelda_Grey.png]],(32*5),(32*3))
	end
	if mode == "keysanity" then
		drawSpace.DrawImage([[.\images\hud\]] .. q ..".png",(32*5)+16,(32*3)+16)
	end
end

function updateBosses()
	updateLWBs()
	updateDWBs()
	updateAgaState()
	updateEscape()
end

function updateItemGrid()
	drawArray(ItemsArray)
	updateCrystals()
	updateHeartPieces()
	updateQuiver()
	updateBombBag()
	updateBottles()
	updatePendants()
	updateBosses()
	menuWasOpened = false
	drawSpace.Refresh()
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
			return seed
		end
	end
end

function mainLoop()
	while true do
		emu.frameadvance()
		q = joypad.get(1)
		
		if game_clear == true then
			gui.text(3,3,"You beat the game!")
		elseif game_clear == false then
			getCurrentRoomByID()
		else
			gui.text(3,3,"Boolean game_clear neither true nor false..?")
		end
		
		if (q.Start == true) then
			updateItemGrid()
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
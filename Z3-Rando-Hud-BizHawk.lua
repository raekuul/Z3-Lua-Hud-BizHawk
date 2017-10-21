-- Z3-Rando-Hud-BizHawk.lua - BizHawk Version
-- Version 1 "Armos Knight"
require 'Z3-Rando-Hud-Addresses'

console.clear()
print("Script initialized.")
warning = "This run is not SRL Legal!"

res = [[.\res\]]
blank = [[blank.png]]

memory.usememorydomain("WRAM")

menuWasOpened = false

drawSpace = gui.createcanvas(224,224)
drawSpace.Clear(0xff000000)
client.SetClientExtraPadding(0,20,0,20)

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
		--console.log(array[k][q] .. " at row ".. row .. " and col " .. column)
		column = column + 1
		end
	--console.log("Yep.")
end

function setMUFlag()
end

function updatePendants()
	p = {values={[0] = 0, 0, 0},paths={[0]=res.."pendant1.png",res.."pendant2.png",res.."pendant4.png"}}
	for r=0,2,1 do
		p.values[r] = bit.check(memory.read_u8(pendants.address),r)
		if p.values[r] == false then
			drawSpace.DrawImage(res .. "pendant0.png",32*pendants.col,32*(pendants.row + r))
		else
			drawSpace.DrawImage(p.paths[r],32*pendants.col,32*(pendants.row + r))
		end
	end
end

function updateCrystals()
	p = {values={[0] = 0, 0, 0, 0, 0, 0, 0}}
	for r=0,6,1 do
		p.values[r] = bit.check(memory.read_u8(crystals.address),r)
		if p.values[r] == false then
			drawSpace.DrawImage(res .. "crystal0.png",32*crystals.col,32*(crystals.row + r))
		else
			drawSpace.DrawImage(res .. "crystal"..r..".png",32*crystals.col,32*(crystals.row + r))
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
	path = [[.\quiver\]] .. r .. [[.png]]
	drawSpace.DrawImage(path,32*quiver.col,32*quiver.row)
end

function updateBottles()
	q = { }
	paths = { }
	for r=0,3,1 do
		q[r] = memory.read_u8(0xf35c + r)
		paths[r] = [[.\bottles\]] .. q[r] .. [[.png]]
		drawSpace.DrawImage(paths[r],32*r,32*bottle.row)
	end
end

function updateBombBag()
	q = memory.read_u8(bomb_bag.address)
	r = q + 10
	path = [[.\bomb_bag\]] .. r .. [[.png]]
	drawSpace.DrawImage(path,32*bomb_bag.col,32*bomb_bag.row)
end

function updateItemGrid()
	drawArray(ItemsArray)
	updateCrystals()
	updateHeartPieces()
	updateQuiver()
	updateBombBag()
	updateBottles()
	updatePendants()
	menuWasOpened = false
	drawSpace.Refresh()
end

while true do
	emu.frameadvance()
	gui.text(0,1,warning)

	q = joypad.get(1)
	if (q.Start == true) then
		updateItemGrid()
	end
end
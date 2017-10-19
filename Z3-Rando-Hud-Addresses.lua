-- Z3-Rando-Hud-Addresses
-- Accurate as of vt26
-- Addresses are from WRAM

res = [[.\res\]]
blank = [[blank.png]]

moneyLow = {address=0xF360}
moneyHi = {address=0xF361}

maxLife = {address=0xF36C}
heartPiece = {address=0xF36B, row=4, col=0, [0]=res .. "hp0.png", res .. "hp1.png", res .. "hp2.png", res .. "hp+3.png"}

quiver = {address=0xF371, row=5, col=4, [0] = res .. blank}
bomb_bag = {address=0xF370, row=0, col=3, [0] = res .. blank}
bottle = {address=0xF35C, row=6, col=0, [0] = res .. blank}

pendants = {address=0xF374, row=0, col=5}
crystals = {address=0xF37A, row=0, col=6}


-- Y ITEMS ARRAY
ItemsArray = {
	bow = {address=0xF340, row=0, col=0, [0] = res .. blank, res .. "bow1.png", res .. "bow2.png", res .. "bow3.png", res .. "bow4.png"},
	boomerang = {address=0xF341, row=0, col=1, [0] = res .. blank, res .. "boom1.png", res .. "boom2.png"},
	hookshot = {address=0xF342, row=0, col=2,[0] = res .. blank, res .. "hookshot.png"},
	mushroom = {address=0xF344, row=0, col=4,[0] = res .. blank, res .. "mushroom.png", res .. "powder.png"},
	fire = {address=0xF345, row=1, col=0,[0] = res .. blank, res .. "fire.png"},
	ice = {address=0xF346, row=1, col=1,[0] = res .. blank, res .. "ice.png"},
	bombos = {address=0xF347, row=1, col=2,[0] = res .. blank, res .. "bombos.png"},
	ether = {address=0xF348, row=1, col=3,[0] = res .. blank, res .. "ether.png"},
	quake = {address=0xF349, row=1, col=4,[0] = res .. blank, res .. "quake.png"},
	lamp = {address=0xF34A, row=2, col=0,[0] = res .. blank, res .. "lamp.png"},
	hammer = {address=0xF34B,row=2, col=1, [0] = res .. blank, res .. "hammer.png"},
	shovel = {address=0xF34C,row=2, col=2, [0] = res .. blank, res .. "shovel.png", res .. "flute.png", res .. "flute.png"},
	net = {address=0xF34D,row=2, col=3, [0] = res .. blank, res .. "net.png"},
	book = {address=0xF34E,row=2, col=4, [0] = res .. blank, res .. "book.png"},
	somaria = {address=0xF350,row=3, col=1, [0] = res .. blank, res .. "somaria.png"},
	byrna = {address=0xF351,row=3, col=2, [0] = res .. blank, res .. "byrna.png"},
	cape = {address=0xF352,row=3, col=3, [0] = res .. blank, res .. "cape.png"},
	mirror = {address=0xF353,row=3, col=4, [0] = res .. blank, res .. "letter.png", res .. "mirror.png"},
	gloves = {address=0xF354,row=4, col=2, [0] = res .. blank, res .. "gloves1.png", res .. "gloves2.png"},
	boots = {address=0xF355,row=4, col=1, [0] = res .. blank, res .. "boots.png", res .. "boots.png"},
	flippers = {address=0xF356,row=4, col=3, [0] = res .. blank, res .. "flippers.png"},
	pearl = {address=0xF357,row=4, col=4, [0] = res .. blank, res .. "pearl.png"},
	sword = {address=0xF359,row=5, col=1, [0] = res .. blank, res .. "sword1.png", res .. "sword2.png", res .. "sword3.png", res .. "sword4.png"},
	shield = {address=0xF35A,row=5, col=2, [0] = res .. blank, res .. "shield1.png", res .. "shield2.png", res .. "shield3.png"},
	armor = {address=0xF35B,row=5, col=3, [0] = res .. "tunic0.png", res .. "tunic1.png", res .. "tunic2.png"},
	magic = {address=0xF37B,row=5, col=0, [0] = res .. "magic0.png", res .. "magic1.png", res .. "magic2.png"}
}
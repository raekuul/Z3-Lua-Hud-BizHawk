# Z3-Rando-Hud-BizHawk

Designed for use with BizHawk (using the BSNES core - the Snes9x core doesn't support memory hooks yet). 
Could possibly be adapted for use with Snes9x, but requires memory hooks to be implemented.

Known issues:
	Magic reduction is implemented but untested. Do not assume that it's working.
	Plot Coupons (Pendants/Crystals/Aga1) are tracked, but do not presently correspond to crystal number
		This is because the game reads the bits weirdly - the Pendant of Courage is tracked in bit 2 rather than bit 0, for example.
	Switchable items (other than bottles) are tracked based on what is selected in the menu, not by what is available.
		Similarly: the Mushroom (and if ever implemented in Rando, the Bottleshrooms and Letter) are no longer tracked once delivered.
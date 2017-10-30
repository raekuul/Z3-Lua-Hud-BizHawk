# Z3-Lua-Hud-BizHawk

Designed for use with BizHawk (using the BSNES core - the Snes9x core doesn't support memory hooks yet).  
Could possibly be adapted for use with Snes9x, but requires memory hooks to be implemented.  

2017-10-30 - added options for regular flavor, keysanity or dungeon item tracking (and it works, thanks to Masterjun)

Known issues:  

  Key tracking does NOT work outside of Keysanity! (This is not something I can fix myself since I don't know why it's broken)  
  1/2 Magic tracking is working, but I don't know if 1/4 Magic is tracked properly.  
  Switchable items (other than bottles) are tracked based on what is selected in the menu, not by what is available.  
  Similarly: the Mushroom (and if ever implemented in Rando, the Bottleshrooms and Letter) are no longer tracked once delivered.
# Z3-Lua-Hud-BizHawk

Designed for use with BizHawk
Could possibly be adapted for use with Snes9x directly, but requires a canvas library for full implementation.

2017-11-19 - added Room and Zone Display

Known issues:  

  Key tracking does NOT work outside of Keysanity!  (This is not something I can fix myself since I don't know why it's broken)  
  Switchable items (other than bottles) are tracked based on what is selected in the menu, not by what is available.  
  Similarly:  the Mushroom (and if ever implemented in Rando, the Bottleshrooms and Letter) are no longer tracked once delivered.
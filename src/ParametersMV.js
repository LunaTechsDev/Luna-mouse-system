/*:
 * @plugindesc Allows you to use custom mouse cursor images and to change them during specific actions.
 * <Luna_MouseSystem>
 *
 * @target MV MZ
 * @author LunaTechs | inc0der
 * @url https://lunatechs.dev/plugins/luna-mouse-system/
 * 
 * @param cursors
 * @test Cursors
 * @desc A list of default cursors
 * @type struct<CursorData>[]
 * @default []
 * 
 * @param hoverEvents
 * @test Hover Events
 * @desc A list of events and their default cursors
 * @type struct<EventCursorData>[]
 * @default []
 * 
 * @param hoverEventCommands
 * @test Hover Event Commands
 * @desc A list of command and the default cursors to use when an event has a command.
 * @type struct<EventCommandData>
 * @default 
 * 
 * 
@help
==== Summary  ====
This plugin allows you to use custom cursor images with a highly customizable
hover event system.

=== Hover Events ===
Hover events are events that automatically change the cursors image to one
which better represents what the event contains.

The cursor will change with the following event commands and may be customized
in the plugins parameters.

  - Show Text
  - Change Gold
  - Change Item
  - Change Equip
  - Transfer
  - Battle
  - Shop
  - Save

==== Plugin Commands ====
The plugin command information is for MV but still contains valuable
information for MZ as well. 

For MZ, the commands and what they do are explained in the new plugin command
manager!

Main Command: LunaMouse 
  as shorter alternatives you may use lms or lmouse

-----------------------
LunaMouse show
-----------------------
show - Keyword for showing the cursor if not already visible

-----------------------
LunaMouse hide [showDefaultCursor]
-----------------------
show - Keyword for showing the cursor if not already visible

showDefaultCursor - Set to true to bring back the default mouse cursor

-----------------------
LunaMouse change [cursorName]
-----------------------
show - Keyword for showing the cursor if not already visible

cursorName - Set to the name of the cursor image file previously set in the 
             parameters

=== Contact us ===
[Website] : https://lunatechs.dev
[Twitter] : https://twitter.com/LunaTechsDev
[Github]  : https://github.com/LunaTechsDev
[Patreon] : https://patreon.com/LunaTechsDev

 
=== License ===
This plugin is released under MIT license.
https://mit-license.org/

Copyright (c) 2020 LunaTechsDev
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE
 * 
 */

/*~struct~CursorData:
 * @param filename
 * @text Cursor Image
 * @desc The image to use as the default cursor
 * @type file
 * @dir img/system
 * @default GameCursor.png 
 */

/*~struct~EventCursorData:
 * @param eventName
 * @text Event Name
 * @desc The event name this cursor data applies to
 * @type text
 * @default
 * 
 * @param filename
 * @text Hover Image Filename
 * @desc The image to use as the hover image
 * @type file
 * @dir img/system
 * @default GameCursor.png 
 */

/*~struct~EventCommandData:
 * @param showText
 * @text Show Text
 * @desc The cursor image to use when hovering over an event with the show text command.
 * @type file
 * @dir img/system
 * @default GameCursor.png 
 * 
 * @param changeEquip
 * @text Change Equip
 * @desc The cursor image to use when hovering over an event with the change equip command.
 * @type file
 * @dir img/system
 * @default GameCursor.png 
 * 
 * @param changeItem
 * @text Change Item
 * @desc The cursor image to use when hovering over an event with the change item command.
 * @type file
 * @dir img/system
 * @default GameCursor.png 
 * 
 * @param changeGold
 * @text Change Gold
 * @desc The cursor image to use when hovering over an event with the change gold command.
 * @type file
 * @dir img/system
 * @default GameCursor.png 
 * 
 * @param transfer
 * @text Transfer
 * @desc The cursor image to use when hovering over an event with the transfer command.
 * @type file
 * @dir img/system
 * @default GameCursor.png 
 * 
 * @param vehicle
 * @text On/Off Vehicle
 * @desc The cursor image to use when hovering over an event with the on/off vehicle command.
 * @type file
 * @dir img/system
 * @default GameCursor.png 
 * 
 * @param battle
 * @text Battle Porcessing
 * @desc The cursor image to use when hovering over an event with the battle processing command.
 * @type file
 * @dir img/system
 * @default GameCursor.png 
 * 
 * @param shop
 * @text Shop Processing
 * @desc The cursor image to use when hovering over an event with the shop processing command.
 * @type file
 * @dir img/system
 * @default GameCursor.png 
 * 
 * @param save
 * @text Save
 * @desc The cursor image to use when hovering over an event with the save command.
 * @type file
 * @dir img/system
 * @default GameCursor.png 
 */

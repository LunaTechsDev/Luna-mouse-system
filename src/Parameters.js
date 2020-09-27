/*:
 * @plugindesc Allows you to use custom mouse cursor images and to change them during specific actions.
 * <Luna_MouseSystem>
 *
 * @target MZ MV
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
 * @command changeCursor
 * @text Change Cursor
 * @desc Changes the current cursor
 * 
 * @arg filename
 * @text Cursor Filename
 * @desc The filename of the cursor you want to change to.
 * @type file
 * @dir img/system
 * @default GameCursor.png
 * 
 * @command hideCursor
 * @text Hide Cursor
 * @desc Hides the cursor from view.
 * @type Bool
 * @default true
 * 
 * @arg showDefault
 * @desc Show the default MZ/MV mouse cursor after hiding your custom cursor?
 * @type boolean
 * @default true
 * @on Show default cursor
 * @off Hide default cursor
 * 
 * @command showCursor
 * @text Show Cursor
 * @desc Brings cursor back to view
 * @type Bool
 * @default true
 * 
@help

A plugin that allows you to use custom mouse cursor images and to change them
during specific actions.
 
MIT License
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

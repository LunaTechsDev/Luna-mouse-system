package scenes;

import rm.types.RPG.Event;
import rm.Globals.DataMap;
import rm.Globals.GameMap;
import core.CursorLoader;
import rm.objects.Game_Event;
import rm.scenes.Scene_Map as RmScene_Map;

using Lambda;
using StringTools;

class Scene_Map extends RmScene_Map {
  public function isEventTouched(event: Game_Event): Bool {
    /**
     * @TODO add offset option via notetags or parameters
     */
    var mx = untyped TouchInput.mouseX;
    var my = untyped TouchInput.mouseY;
    var rect = { x: event.screenX() - 24, width: 48, height: 48, y: event.screenY() - 24 };
    return mx > rect.x && mx < rect.x + rect.width && my > rect.y && my < rect.y + rect.height;
  }

  public function eventTouchedByMouse(): Game_Event {
    var events: Array<Game_Event> = GameMap.events();
    return events.find(event -> isEventTouched(event));
  }

  public function evaulateNotebox(event: Game_Event) {
    var data: Event = DataMap.events[event.eventId()];
    if (data.note != null) {
      var cursorName = data.note.split(':')[1];
      if (cursorName != null) {
        CursorLoader.changeHoverData(cursorName.trim());
      }
    }
  }

  public function evaulateNamebox(event: Game_Event) {
    var data: Event = DataMap.events[event.eventId()];
    if (data.name != null) {
      var cursorData = Main.params.hoverEvents.find(e -> e.eventName == data.name);
      if (cursorData != null) {
        CursorLoader.changeHoverData(cursorData.filename);
      }
    }
  }

  /**
   * @TODO Change to read command lists and pages upon map load instead of during update
   */
  public function evaluateCommandList(event: Game_Event) {
    var hasCommand = {
      showText: false,
      changeEquip: false,
      changeItem: false,
      changeGold: false,
      transfer: false,
      vehicle: false,
      battle: false,
      shop: false,
      save: false
    }
    var page = event.page();

    for (command in page.list) {
      var code = command.code;
      if (code == 101) {
        hasCommand.showText = true;
      }
      if (code == 128 || code == 127) {
        hasCommand.changeEquip = true;
        break;
      }
      if (code == 125) {
        hasCommand.changeGold = true;
        break;
      }
      if (code == 126) {
        hasCommand.changeItem = true;
        break;
      }
      if (code == 201) {
        hasCommand.transfer = true;
        break;
      }
      if (code == 206) {
        hasCommand.vehicle = true;
        break;
      }
      if (code == 301) {
        hasCommand.battle = true;
        break;
      }
      if (code == 302) {
        hasCommand.shop = true;
        break;
      }
      if (code == 352) {
        hasCommand.save = true;
        break;
      }
    }

    for (command in Reflect.fields(hasCommand)) {
      var value = Reflect.getProperty(hasCommand, command);
      if (value && CursorLoader.activeData.name != command) {
        var name = Reflect.getProperty(Main.params.hoverEventCommands, command);
        CursorLoader.changeHoverData(name);
        break;
      } else {
        CursorLoader.resetHoverName();
      }
    }
  }

  public override function updateMain() {
    untyped _Scene_Map_updateMain.call(this);
    var eventTouched = eventTouchedByMouse();
    if (eventTouched != null) {
      untyped this._cursor.hover = true;
      evaulateNamebox(eventTouched);
      evaulateNotebox(eventTouched);
      evaluateCommandList(eventTouched);
    } else {
      untyped this._cursor.hover = false;
    }
  }
}

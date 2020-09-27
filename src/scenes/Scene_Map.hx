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
    var mouseMapX = GameMap.canvasToMapX(untyped TouchInput.mouseX);
    var mouseMapY = GameMap.canvasToMapY(untyped TouchInput.mouseY);
    return event.x == mouseMapX && event.y == mouseMapY;
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

  public override function updateMain() {
    untyped _Scene_Map_updateMain.call(this);
    var eventTouched = eventTouchedByMouse();
    if (eventTouched != null) {
      untyped this._cursor.hover = true;
      evaulateNamebox(eventTouched);
      evaulateNotebox(eventTouched);
    } else {
      untyped this._cursor.hover = false;
    }
  }
}

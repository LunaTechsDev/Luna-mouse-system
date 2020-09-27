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

  public override function updateMain() {
    untyped _Scene_Map_updateMain.call(this);
    var eventTouched = eventTouchedByMouse();
    if (eventTouched != null) {
      var eventData: Event = DataMap.events[eventTouched.eventId()];
      if (eventData.note != null) {
        var cursorName = eventData.note.split(':')[1];
        if (cursorName != null) {
          CursorLoader.changeHoverData(cursorName.trim());
          untyped this._cursor.hover = true;
        }
      }
    } else {
      untyped this._cursor.hover = false;
    }
  }
}

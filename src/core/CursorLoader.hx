package core;

import haxe.ds.Map;
import sprites.CursorSprite;
import types.CursorData;

class CursorLoader {
  private static var cursors: Map<String, CursorData> = new Map();

  public static var activeData(default, set): CursorData;

  public static function set_activeData(data: CursorData) {
    getActiveCursor().cursorData = data;
    return activeData = data;
  }

  public static function hasActiveData(): Bool {
    return activeData != null;
  }

  public static function removeCursor(data: CursorData) {
    if (cursors.exists(data.name)) {
      cursors.remove(data.name);
    }
  }

  public static function addCursor(data: CursorData) {
    if (!cursors.exists(data.name)) {
      cursors.set(data.name, data);
    }
  }

  public static function changeCursor(name: String) {
    if (cursors.exists(name)) {
      var data = cursors.get(name);
      activeData = data;
    }
  }

  public static function getActiveCursor(): CursorSprite {
    return untyped Amaryllis.currentScene()._cursor;
  }
}

package core;

import haxe.ds.Map;
import sprites.CursorSprite;
import types.CursorData;
import rm.Globals.GameSystem;

class CursorLoader {
  private static var cursors: Map<String, CursorData> = new Map();

  public static var activeData: CursorData;

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

  /**
   * Retrieve CursorData by name, if none exist it will return the active CursorData
   * @param name The name the CursorData is associated with
   * @return CursorData
   */
  public static function getCursorData(name: String): CursorData {
    if (cursors.exists(name)) {
      return cursors.get(name);
    }
    return activeData;
  }

  public static function changeCursor(name: String) {
    if (cursors.exists(name)) {
      var data = cursors.get(name);
      activeData = data;
      getActiveCursor().cursorData = activeData;
      untyped GameSystem.activeCursor = activeData;
    }
  }

  public static function changeHoverData(hoverName: String) {
    if (activeData.hoverName != null) {
      activeData.hoverName = hoverName;
    }
    getActiveCursor().cursorData.hoverName = hoverName;
  }

  public static function getActiveCursor(): CursorSprite {
    return untyped Amaryllis.currentScene()._cursor;
  }
}

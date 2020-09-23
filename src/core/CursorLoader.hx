package core;

import rm.core.Bitmap;
import sprites.CursorSprite;
import rm.managers.ImageManager;

class CursorLoader {
  private var _cache: Array<CursorSprite> = [];

  public static function createCursor(?bitmap: Bitmap) {
    if (bitmap == null) {
      bitmap = ImageManager.loadSystem(Main.params.cursorFilepath);
    }
    var sprite = new CursorSprite(bitmap);
    sprite.anchor.set(0, 0);
    return sprite;
  }

  public static function loadCursor(?swap: Bool, onLoad: Dynamic->CursorSprite) {

  }

  public static function swapCursor(cursorId) {}

  public static function activeCursor(): CursorSprite {
    return untyped Amaryllis.currentScene()._cursor;
  }
}

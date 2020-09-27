package sprites;

import rm.core.Sprite;
import rm.managers.ImageManager;
import types.CursorData;

class CursorSprite extends Sprite {
  public var cursorData(default, set): CursorData;

  public function new(bitmap, ?cursorData: CursorData) {
    super(bitmap);
    if (cursorData != null) {
      this.cursorData = cursorData;
    }
    this.cursorData = {
      name: Utils.parseFilename(bitmap.url, false),
      url: bitmap.url,
    }
  }

  public function get_cursorData(): CursorData {
    return this.cursorData;
  }

  public function set_cursorData(cursorData: CursorData) {
    if (this.bitmap.url != cursorData.url) {
      this.bitmap = ImageManager.loadSystem(cursorData.name);
    }
    return this.cursorData = cursorData;
  }
}

package sprites;

import rm.core.Sprite;
import rm.managers.ImageManager;
import core.CursorLoader;
import types.CursorData;

class CursorSprite extends Sprite {
  public var cursorData(default, set): CursorData;
  public var hover: Bool;

  public function new(bitmap, ?cursorData: CursorData) {
    super(bitmap);
    if (cursorData != null) {
      this.cursorData = cursorData;
    }
    this.cursorData = {
      name: Utils.parseFilename(bitmap.url, false),
      url: bitmap.url,
      hoverName: ''
    }
  }

  public override function update() {
    super.update();
    if (hover) {
      var hoverData = CursorLoader.getCursorData(cursorData.hoverName);
      if (hoverData != null && bitmap.url != hoverData.url) {
        bitmap = ImageManager.loadSystem(hoverData.name);
      }
    } else if (bitmap.url != cursorData.url) {
      bitmap = ImageManager.loadSystem(cursorData.name);
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

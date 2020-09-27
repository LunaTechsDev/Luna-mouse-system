package core;

import js.html.MouseEvent;
import rm.managers.DataManager;
import sprites.CursorSprite;
import rm.core.TouchInput;
import rm.core.Stage as RmStage;
import rm.Globals.GameSystem;

using Lambda;

class Stage extends RmStage {
  public var _cursorListener: Any;
  public var _cursor: sprites.CursorSprite;

  public override function initialize() {
    untyped _Stage_initialize.call(this);
    this._cursorListener = this._mouseMoveListener;
    untyped TouchInput.addMouseMoveListener(this._cursorListener);
    this.updateCursors();
    untyped document.body.style.cursor = 'none';
  }

  public function createMouseCursor(filename: String) {
    var cursors: Array<Dynamic> = Main.params.cursors;
    untyped {
      var bitmap = ImageManager.loadSystem(filename);
      this._cursor = new CursorSprite(bitmap, {
        name: filename,
        url: bitmap.url
      });
      this.addChild(this._cursor);
    }
  }

  public function updateCursors(): Void {
    var cursors: Array<Dynamic> = Main.params.cursors;
    var needsUpdate: Bool = DataManager.isDatabaseLoaded() && CursorLoader.activeData == null;
  
    if (needsUpdate && untyped GameSystem.activeCursor != null) {
      CursorLoader.activeData = untyped GameSystem.activeCursor;
    }

    if (CursorLoader.hasActiveData()) {
      untyped this.createMouseCursor(CursorLoader.activeData.name);
    } else {
      untyped this.createMouseCursor(Main.params.cursors[0].filename);
    }

    for (cursor in cursors) {
      CursorLoader.addCursor({
        name: cursor.filename,
        url: 'img/system/${cursor.filename}.png',
      });
    }
  }

  private function _mouseMoveListener(event: MouseEvent): Void {
    if (this._cursor != null) {
      this._cursor.x = event.clientX;
      this._cursor.y = event.clientY;
    }
  }
}

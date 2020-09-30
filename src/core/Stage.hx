package core;

import js.html.MouseEvent;
import rm.managers.ImageManager;
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
    var bitmap = ImageManager.loadSystem(filename);
    untyped {
      var data = {
        name: filename,
        url: bitmap.url,
        hoverName: ''
      }
      CursorLoader.activeData = data;
      untyped this._cursor = new CursorSprite(bitmap, data);
      this.addChild(this._cursor);
    }
  }

  public function updateCursors(): Void {
    var cursors: Array<Dynamic> = Main.params.cursors;
    
    if (DataManager.isDatabaseLoaded() && untyped GameSystem.activeCursor != null) {
      if (untyped GameSystem.activeCursor != CursorLoader.activeData) {
        CursorLoader.activeData = untyped GameSystem.activeCursor;
      }
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
        hoverName: ''
      });
    }
    for (cursor in Reflect.fields(Main.params.hoverEventCommands)) {
      var filename = Reflect.getProperty(Main.params.hoverEventCommands, cursor);
      CursorLoader.addCursor({
        name: filename,
        url: 'img/system/${filename}.png',
        hoverName: filename
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

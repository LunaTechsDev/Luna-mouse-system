package scenes;

import rm.core.TouchInput;
import core.CursorLoader;
import rm.scenes.Scene_Base as RmScene_Base;

class Scene_Base extends RmScene_Base {
  public override function initialize() {
    untyped {
      _Scene_Base_initialize.call(this);
      if (this._cursor) {
        this._cursor.x = TouchInput.mouseX;
        this._cursor.y = TouchInput.mouseY;
      }
    }
    CursorLoader.on('cursor-change', onCursorChange);
    CursorLoader.on('cursor-hover-change', onCursorHoverChange);
  }

  public function onCursorChange(data) {
    untyped this._cursor.cursorData = data;
  }

  public function onCursorHoverChange(hoverName) {
    untyped this._cursor.cursorData.hoverName = hoverName;
  }

  /**
   * hacky way to ensure cursor is always on top of all sprites
   */
  public override function updateChildren() {
    untyped _Scene_Base_updateChildren.call(this);
    if (this.children.indexOf(untyped this._cursor) != this.children.length - 1) {
      this.removeChild(untyped this._cursor);
      this.addChild(untyped this._cursor);
    }
  }

  public override function terminate() {
    if (untyped this._cursorListener) {
      untyped TouchInput.removeMouseMoveListener(this._cursorListener);
    }
  }
}

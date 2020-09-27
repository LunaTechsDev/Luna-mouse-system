package core;

import js.html.MouseEvent;
import rm.core.TouchInput as RmTouchInput;

using Lambda;

class TouchInput extends RmTouchInput {
  private var mouseX: Float;
  private var mouseY: Float;
  private var _mouseMoveListeners: Array<Dynamic>;

  public function initialize() {
    untyped _TouchInput_initialize.call(this);
    this._mouseMoveListeners = [];
    this.mouseX = 0;
    this.mouseY = 0;
  }

  private function _onMouseMove(event: MouseEvent) {
    untyped _TouchInput__onMouseMove.call(this, event);
    if (this._mouseMoveListeners.length > 0) {
      for (listener in this._mouseMoveListeners) {
        listener(event);
      }
      this.mouseX = event.clientX;
      this.mouseY = event.clientY;
    }
  }

  public function addMouseMoveListener(listener: Any) {
    if (listener != null) {
      this._mouseMoveListeners.push(listener);
    } else {
      throw new js.lib.Error('Cursor move event listener must be of type function');
    }
  }

  public function removeMouseMoveListener(listener: Any) {
    if (listener != null) {
      var listenerToRemove = this._mouseMoveListeners.find(l -> l == listener);
      if (listenerToRemove) {
        var index = untyped this._mouseMoveListeners.indexOf(listenerToRemove);
        untyped this._mouseMoveListeners.splice(index, 1);
      }
    } else {
      throw new js.lib.Error('Cursor move event listener must be of type function');
    }
  }
}

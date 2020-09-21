package core;

import core.Types.JsFn;
import utils.Comment;
import rm.core.TouchInput;
import macros.FnMacros.self as sf;

using utils.Fn;

class LunaTouchInput {
  public static inline function patch() {
    Comment.title('TouchInput');

    var oldInitialize: JsFn = TouchInput.initializeR;
    TouchInput.initializeD = () -> {
      sf(TouchInput, {
        oldInitialize.call(self);

        untyped {
          self._mouseMoveListeners = [];
          self.mouseX = 0;
          self.mouseY = 0;
        };
      });
    }

    var oldOnMouseMove: JsFn = untyped TouchInput._onMouseMove;
    untyped TouchInput._onMouseMove = (event) -> {
      sf(TouchInput, {
        oldOnMouseMove.call(self, event);
        untyped {
          if (self._mouseMoveListeners.length > 0) {
            var listeners: Array<Dynamic> = self._mouseMoveListeners;
            for (listener in listeners) {
              listener(event);
            }
          }
          self.mouseX = event.clientX;
          self.mouseY = event.clientY;
        }
      });
    }

    Fn.setField(TouchInput, 'addMouseMoveListener', (func: Dynamic, context: Dynamic) -> {
      sf(TouchInput, {
        if (func != null) {
          untyped self._mouseMoveListeners.push(func);
        } else {
          throw new js.lib.Error('Cursor move event listener must be of type function');
        }
      });
    });

    Fn.setField(TouchInput, 'removeMouseMoveListener', (func: Dynamic) -> {
      sf(TouchInput, {
        if (func != null) {
          var listenerToRemove = untyped self._mouseMoveListeners.find(listener -> listener == func);
          if (listenerToRemove) {
            var index = untyped self._mouseMoveListeners.indexOf(listenerToRemove);
            untyped self._mouseMoveListeners.splice(index, 1);
          }
        } else {
          throw new js.lib.Error('Cursor move event listener must be of type function');
        }
      });
    });
  }
}

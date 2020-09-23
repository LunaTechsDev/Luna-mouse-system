package core;

import rm.core.TouchInput;
import core.Types.JsFn;
import utils.Comment;
import rm.core.Stage;
import macros.FnMacros.self as sf;

using utils.Fn;

class LunaStage {
  public static inline function patch() {
    Comment.title('Stage');

    var oldInitialize: JsFn = Stage.proto().initializeR;
    Stage.proto().initializeD = () -> {
      sf(Stage, {
        oldInitialize.call(self);
        untyped {
          self._cursorListener = self._mouseMoveListener.bind(self);
          TouchInput.addMouseMoveListener(self._cursorListener);
          self.createMouseCursor();
          document.body.style.cursor = 'none';
        }
      });
    }

    Stage.setPrPropFn('createMouseCursor', () -> {
      sf(Stage, {
        untyped {
          self._cursor = CursorLoader.createCursor();
          self.addChild(self._cursor);
        }
      });
    });

    Stage.setPrProp('_mouseMoveListener', (event) -> {
      sf(Stage, {
        untyped {
          if (self._cursor) {
            self._cursor.x = event.clientX;
            self._cursor.y = event.clientY;
          }
        }
      });
    });
  }
}

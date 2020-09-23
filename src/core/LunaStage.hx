package core;

import rm.core.TouchInput;
import core.Types.JsFn;
import utils.Comment;
import rm.core.Sprite;
import rm.core.Stage;
import rm.managers.ImageManager;
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
          var cursorBitmap = ImageManager.loadSystem(Main.params.cursorFilepath);
          self._cursor = new Sprite(cursorBitmap);
          self._cursor.anchor.set(0, 0);
          self._cursor.x = 200;
          self._cursor.y = 200;
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

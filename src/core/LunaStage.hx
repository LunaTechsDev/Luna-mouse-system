package core;

import sprites.CursorSprite;
import rm.core.TouchInput;
import core.Types.JsFn;
import utils.Comment;
import types.CursorData;
import rm.core.Stage;
import macros.FnMacros.self as sf;

using utils.Fn;
using Lambda;

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
        var cursors: Array<Dynamic> = Main.params.cursors;
        for (cursor in cursors) {
          CursorLoader.addCursor({
            name: cursor.filename,
            url: 'img/system/${cursor.filename}.png',
          });
        }
        untyped {
          var defaultCursor = Main.params.cursors[0];
          var bitmap = ImageManager.loadSystem(defaultCursor.filename);
          self._cursor = new CursorSprite(bitmap, {
            name: defaultCursor.filename,
            url: bitmap.url
          });
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

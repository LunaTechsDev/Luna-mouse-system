package core;

import rm.managers.DataManager;
import sprites.CursorSprite;
import rm.core.TouchInput;
import core.Types.JsFn;
import utils.Comment;
import rm.core.Stage;
import rm.Globals.GameSystem;
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
          self.updateCursors();
          document.body.style.cursor = 'none';
        }
      });
    }

    Stage.setPrPropFn('createMouseCursor', (filename: String) -> {
      sf(Stage, {
        var cursors: Array<Dynamic> = Main.params.cursors;
        untyped {
          var bitmap = ImageManager.loadSystem(filename);
          self._cursor = new CursorSprite(bitmap, {
            name: filename,
            url: bitmap.url
          });
          self.addChild(self._cursor);
        }
      });
    });

    Stage.setPrPropFn('updateCursors', () -> {
      sf(Stage, {
        var cursors: Array<Dynamic> = Main.params.cursors;
        if (DataManager.isDatabaseLoaded() && CursorLoader.activeData == null && untyped GameSystem.activeCursor != null) {
          CursorLoader.activeData = untyped GameSystem.activeCursor;
        }
        if (CursorLoader.hasActiveData()) {
          untyped self.createMouseCursor(CursorLoader.activeData.name);
        } else {
          untyped self.createMouseCursor(Main.params.cursors[0].filename);
        }
        for (cursor in cursors) {
          CursorLoader.addCursor({
            name: cursor.filename,
            url: 'img/system/${cursor.filename}.png',
          });
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

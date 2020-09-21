package scenes;

import rm.core.TouchInput;
import core.Types.JsFn;
import rm.scenes.Scene_Base;
import utils.Comment;
import macros.FnMacros.self as sf;

using utils.Fn;

class LunaSceneBase {
  public static inline function patch() {
    Comment.title('Scene_Base');

    var oldInitialize: JsFn = Scene_Base.proto().initializeR;
    Scene_Base.proto().initializeD = () -> {
      sf(Scene_Base, {
        oldInitialize.call(self);
        untyped {
          if (self._cursor) {
            self._cursor.x = TouchInput.mouseX;
            self._cursor.y = TouchInput.mouseY;
          }
        }
      });
    }

    /**
     * hacky way to ensure cursor is always on top of all sprites
     */
    var oldUpdateChildren = Scene_Base.proto().updateChildrenR;
    Scene_Base.proto().updateChildrenD = () -> {
      sf(Scene_Base, {
        oldUpdateChildren.call(self);
        untyped {
          if (self.children.indexOf(self._cursor) != self.children.length - 1) {
            self.removeChild(self._cursor);
            self.addChild(self._cursor);
          }
        }
      });
    }

    var oldTerminate = Scene_Base.proto().terminateR;
    Scene_Base.proto().terminateR = () -> {
      sf(Scene_Base, {
        oldTerminate.call(self);
        untyped {
          if (self._cursorListener) {
            TouchInput.removeMouseMoveListener(self._cursorListener);
          }
        }
      });
    }
  }
}

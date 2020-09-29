import rm.objects.Game_Interpreter;
import sprites.CursorSprite;
import core.CursorLoader;
import core.Amaryllis;

using StringTools;
using Lambda;

@:keep()
class PluginCommandsMV extends Game_Interpreter {
  public override function pluginCommand(command: String, args: Array<String>) {
    var commands = ['lms', 'lunamouse', 'lmouse'];
    var truthy = ['true', 'on', 'yes'];

    if (commands.exists(c -> c == command)) {
      var subCommand = args[0].toLowerCase();

      switch (subCommand) {
        case 'show':
          var cursor: CursorSprite = untyped Amaryllis.currentScene()._cursor;
          cursor.visible = true;
          untyped document.body.style.cursor = 'none';
        case 'hide':
          var cursor: CursorSprite = untyped Amaryllis.currentScene()._cursor;
          cursor.visible = false;
          if (truthy.exists(t -> t == args[1].toLowerCase())) {
            untyped document.body.style.cursor = 'auto';
          }
        case 'change':
          CursorLoader.changeCursor(args[1]);
      }
    }
  }
}

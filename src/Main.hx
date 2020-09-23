import rm.managers.ImageManager;
import core.CursorLoader;
import sprites.CursorSprite;
import core.Amaryllis;
import rm.Globals;
import scenes.LunaSceneBase;
import core.LunaTouchInput;
import core.LunaStage;
import utils.Parse;
import rm.managers.PluginManager;
import rm.types.RM.PluginSettings;

using StringTools;
using Lambda;

class Main {
  public static var pluginName: String = 'Luna_MouseSystem';
  public static var params: Dynamic;

  public static function main() {
    var rawParams = Globals.Plugins.find((p: PluginSettings) -> p.description.contains('<Luna_MouseSystem>')).parameters;
    params = Parse.parseParameters(cast rawParams);
    LunaTouchInput.patch();
    LunaStage.patch();
    LunaSceneBase.patch();
    registerPluginCommands();
  }

  public static function registerPluginCommands () {
    #if !compileMV
    PluginManager.registerCommand(pluginName, 'showCursor', (args) -> {
      var cursor: CursorSprite = untyped Amaryllis.currentScene()._cursor;
      cursor.visible = true;
      untyped document.body.style.cursor = 'none';
    });
    
    PluginManager.registerCommand(pluginName, 'hideCursor', (args) -> {
      var option: Dynamic = Parse.parseParameters(args);
      var cursor: CursorSprite = untyped Amaryllis.currentScene()._cursor;
      cursor.visible = false;
      if (option.showDefault) {
        untyped document.body.style.cursor = 'auto';
      }
    });

    PluginManager.registerCommand(pluginName, 'changeCursor', (args: Dynamic) -> {
      var bitmap = ImageManager.loadSystem(args.filename);
      untyped Amaryllis.currentScene()._cursor.bitmap = bitmap;
    });
    #end
  }

}

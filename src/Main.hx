import macros.FnMacros;
import core.CursorLoader;
import sprites.CursorSprite;
import core.Amaryllis;
import rm.Globals;
import scenes.Scene_Map;
import scenes.Scene_Base;
import core.Game_System;
import core.TouchInput;
import core.Stage;
import utils.Parse;
import rm.objects.Game_System as RmGame_System;
import rm.managers.PluginManager;
import rm.types.RM.PluginSettings;
import rm.core.TouchInput as RmTouchInput;
import rm.core.Stage as RmStage;
import rm.scenes.Scene_Base as RmScene_Base;
import rm.scenes.Scene_Map as RmScene_Map;

using StringTools;
using Lambda;

class Main {
  public static var pluginName: String = 'Luna_MouseSystem';
  public static var params: Dynamic;

  public static function main() {
    var rawParams = Globals.Plugins.find((p: PluginSettings) -> p.description.contains('<Luna_MouseSystem>')).parameters;
    params = Parse.parseParameters(cast rawParams);
    utils.Comment.title('DataManager');
    FnMacros.jsPatch(false, RmTouchInput, TouchInput);
    FnMacros.jsPatch(true, RmStage, Stage);
    FnMacros.jsPatch(false, RmGame_System, Game_System);
    FnMacros.jsPatch(true, RmScene_Base, Scene_Base);
    FnMacros.jsPatch(true, RmScene_Map, Scene_Map);
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
      CursorLoader.changeCursor(args.filename);
    });
    #end
  }

}

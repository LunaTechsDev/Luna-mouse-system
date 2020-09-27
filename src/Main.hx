import macros.FnMacros;
import core.CursorLoader;
import sprites.CursorSprite;
import core.Amaryllis;
import rm.Globals;
import scenes.LunaSceneBase;
import core.Game_System;
import core.LunaTouchInput;
import core.LunaStage;
import utils.Parse;
import rm.objects.Game_System as RmGame_System;
import rm.managers.PluginManager;
import rm.types.RM.PluginSettings;
import rm.core.TouchInput;
import rm.core.Stage;
import rm.scenes.Scene_Base;

using StringTools;
using Lambda;

class Main {
  public static var pluginName: String = 'Luna_MouseSystem';
  public static var params: Dynamic;

  public static function main() {
    var rawParams = Globals.Plugins.find((p: PluginSettings) -> p.description.contains('<Luna_MouseSystem>')).parameters;
    params = Parse.parseParameters(cast rawParams);
    utils.Comment.title('DataManager');
    FnMacros.jsPatch(false, TouchInput, LunaTouchInput);
    FnMacros.jsPatch(true, Stage, LunaStage);
    FnMacros.jsPatch(false, RmGame_System, Game_System);
    FnMacros.jsPatch(true, Scene_Base, LunaSceneBase);
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

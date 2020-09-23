import rm.Globals;
import scenes.LunaSceneBase;
import core.LunaTouchInput;
import core.LunaStage;
import utils.Parse;
import rm.types.RM.PluginSettings;

using StringTools;
using Lambda;

class Main {
  public static var params: Dynamic;

  public static function main() {
    var rawParams = Globals.Plugins.find((p: PluginSettings) -> p.description.contains('<Luna_MouseSystem>')).parameters;
    params = Parse.parseParameters(cast rawParams);
    LunaTouchInput.patch();
    LunaStage.patch();
    LunaSceneBase.patch();
  }
}

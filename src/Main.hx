import scenes.LunaSceneBase;
import core.LunaTouchInput;
import core.LunaStage;

class Main {
  public static function main() {
    LunaTouchInput.patch();
    LunaStage.patch();
    LunaSceneBase.patch();
  }
}

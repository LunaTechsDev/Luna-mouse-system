package core;

import rm.objects.Game_System as RmGame_System;

class Game_System extends RmGame_System {
  public override function initialize() {
    untyped this.activeCursor = CursorLoader.activeData;
    untyped _Game_System_initialize.call(this);
  }
}

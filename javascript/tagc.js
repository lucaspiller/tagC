$(document).ready(function() {
  var emulator, bytecode;

  // TODO load this from somewhere useful
  bytecode = [31905, 65280, 34818, 32787, 32641, 2, 34850, 34866, 33953, 35890, 31905, 255, 36914, 31905, 65280, 36914, 33825, 32641, 2];

  Gt.onStart = function() {
    emulator = new Emulator();
    emulator.run(bytecode);
    emulator.runAsync();
  }

  Gt.onStop = function() {
    emulator.paused = true;
  }

  Gt.onStep = function(ship) {
    var zVal = emulator.Registers.Z.get();
    if (zVal == 0xff00) {
      ship.forward();
    } else if (zVal == 0x00ff) {
      ship.backward();
    }
  }

  Gt.c = new Gt.Controller($('canvas').get(0));
});

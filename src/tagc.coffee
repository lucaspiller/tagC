window.TagC = {}

$ ->
  emulator = bytecode = false

  Gt.onStart = ->
    emulator = new Emulator()
    emulator.run(bytecode)
    emulator.runAsync()

  Gt.onStop = ->
    emulator.paused = true

  Gt.onStep = (ship) ->
    zVal = emulator.Registers.Z.get()
    if zVal == 0xff00
      ship.forward()
    else if zVal == 0x00ff
      ship.backward()

    xVal = emulator.Registers.X.get()
    if xVal == 0xff00
      ship.rotate(-1)
    else if xVal == 0x00ff
      ship.rotate(1)

  defaultBytecode = [31905, 65280, 35010, 44258, 32978, 31776, 13, 31986, 65530, 31776, 26, 32641, 2, 34818, 34834, 33953, 35858, 31905, 255, 36882, 31905, 65280, 36882, 33793, 33985, 25473, 34850, 34866, 33889, 35890, 31841, 255, 36914, 31841, 65280, 36914, 33825, 34017, 25473]

  new TagC.BytecodeLoader $('#bytecode-load').get(0), defaultBytecode, (_bytecode) ->
    bytecode = _bytecode

    # restart DCPU
    Gt.onStart()

  Gt.c = new Gt.Controller($('canvas').get(0))

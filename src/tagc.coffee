window.TagC = {}

$ ->
  emulator = bytecode = false

  Gt.onStart = (ship) ->
    emulator = new Emulator()
    emulator.devices = []

    thrusters = new TagC.Thrusters(emulator, ship)
    emulator.devices.push thrusters

    emulator.run bytecode
    emulator.runAsync()

  Gt.onStop = ->
    emulator.paused = true

  Gt.onStep = ->
    unless emulator.paused
      for device, i in emulator.devices
        device.step() if device.step?

  defaultBytecode = [7680,35043,7712,31762,34455,31794,35324,8129,61,34035,32641,1,34817,31777,61440,31296,61,33985,34017,33889,33921,35010,44258,32978,31776,32,31986,65530,31776,47,32641,21,34914,31786,255,35954,31787,61440,36978,31787,3840,36978,33889,31296,61,33985,25473,34946,31786,65280,35986,31787,240,37010,49195,37010,33921,31296,61,34017,25473,0]

  new TagC.BytecodeLoader $('#bytecode-load').get(0), defaultBytecode, (_bytecode) =>
    bytecode = _bytecode

    if emulator && !emulator.paused
      emulator.boot()
      emulator.run bytecode
      emulator.runAsync()

  Gt.c = new Gt.Controller($('canvas').get(0))

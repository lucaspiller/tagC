class Thrusters
  constructor: (@emulator, @ship) ->
    @id           = 0x89fc8697
    @manufacturer = 0x41acf57b
    @version      = 1

  init: ->
    @state = 0x0000

  interrupt: ->
    code = this.emulator.Registers.A.get()

    switch code
      # 0x0000 - get state of thrusters
      when 0
        this.emulator.Registers.B.set @state
      # 0x0001 - set state of thrusters
      when 1
        @state = this.emulator.Registers.B.get()

  step: ->
    # high byte - forward / reverse
    switch @state >>> 8
      when 0x0f
        @ship.backward()
      when 0xf0
        @ship.forward()

    # low byte - left / right
    switch @state & 0xff
      when 0xf0
        @ship.rotate(-1)
      when 0x0f
        @ship.rotate(1)
      else
        @ship.rotate(0)

TagC.Thrusters = Thrusters

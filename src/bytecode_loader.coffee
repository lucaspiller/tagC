class BytecodeLoader
  constructor: (@element, @defaultBytecode, @callback) ->
    @element.addEventListener 'change', @loadFromFile
    @loadDefault()

  loadDefault: ->
    @callback @defaultBytecode

  loadFromFile: =>
    unless window.FileReader
      alert "Sorry, your browser isn't supported :("
      return

    reader = new FileReader()
    reader.onload = =>
      bytecode = new Array(Math.ceil(reader.result.length / 2))

      i = j = 0
      while i < reader.result.length
        low  = reader.result.charCodeAt(i++) || 0
        high = reader.result.charCodeAt(i++) || 0

        bytecode[j++] = (low << 8) + high

      console.log 'Loaded', bytecode.join(',')
      @callback bytecode

    reader.readAsBinaryString @element.files[0]

TagC.BytecodeLoader = BytecodeLoader

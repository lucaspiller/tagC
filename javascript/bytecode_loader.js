var BytecodeLoader = (function() {
  var _this;

  function BytecodeLoader(element, defaultBytecode, callback) {
    _this = this;

    this.defaultBytecode = defaultBytecode;
    this.callback        = callback;
    this.element         = element;

    this.element.addEventListener('change', this.loadFromFile);
    this.loadDefault();
  }

  BytecodeLoader.prototype.loadDefault = function() {
    this.callback(this.defaultBytecode);
  };

  BytecodeLoader.prototype.loadFromFile = function() {
    if (!window.FileReader) {
      alert("Sorry, your browser isn't supported :(");
      return;
    }

    var reader = new FileReader();
    reader.onload = function() {
      var bytecode = new Uint16Array(Math.ceil(reader.result.length / 2));

      var j = 0, i = 0;
      while (i < reader.result.length) {
        var low  = reader.result.charCodeAt(i++) || 0;
        var high = reader.result.charCodeAt(i++) || 0;

        bytecode[j++] = (low << 8) + high;
      }

      _this.callback(bytecode);
    };
    reader.readAsBinaryString(_this.element.files[0]);
  }

  return BytecodeLoader;
})();

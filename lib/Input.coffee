Field = require("./Field")

class Input extends Field
  constructor: (obj) ->
    @setDefault
      type: "text"
      tag: "input"
    super obj

module.exports = Input;
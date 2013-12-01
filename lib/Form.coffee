Fieldset = require("./Fieldset")
util = require("util")

class Form extends Fieldset
  constructor: (obj) ->
    @setDefault
      tag: "form"

    super obj

  setFieldset: (obj) ->
    _fieldset = new Fieldset(obj)
    @_attributes.fields.push(_fieldset)
    _fieldset

module.exports = Form
Fieldset = require("./Fieldset")
util = require("util")

class Form extends Fieldset
  deafult:
    tag: "form"

  setFieldset: (obj) ->
    _fieldset = new Fieldset(obj)
    @_attributes.fields.push(_fieldset)
    _fieldset

module.exports = Form
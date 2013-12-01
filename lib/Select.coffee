Field = require("./Field")
util = require('util')

class Select extends Field
  constructor: (obj) ->
    @_attributes = {} #TODO: Подумать, как от этого избавится

    @_attributes.option = []
    @_weight = 0
    if obj and obj.option
      @appendOption option for option in obj.option

    super obj


  addOption: (obj) ->
    if obj and !obj.weight then obj.weight = @_weight += 10
    _option = new Option obj
    @_attributes.option.push(_option)
    @_attributes.option = @_sort @_attributes.option

  toObject: ->
    _attributes = util._extend {}, @_attributes
    _fields = _attributes.option

    _fields.forEach (item, key) ->
      _fields[key] = item.toObject()


    _attributes


class Option extends Field
  default:
    value: "",
    text: ""

module.exports = Select


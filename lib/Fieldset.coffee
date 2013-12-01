Field = require("./Field")
Input = require("./Input")
Select = require('./Select')
util = require("util")


class Fieldset extends Field
  constructor: (obj) ->
    @setDefault
      tag: "fieldset",
      fields: []

    if obj and obj.fields
      @setField field for field in obj.fields
      delete obj.fields

    super obj

    @_weight = 0

  setInput: (obj) ->
    _input = new Input obj
    @setField _input

  setCheckBox: (obj) ->
    obj = util._extend {type: "checkbox", select: false}, obj
    @setInput(obj)

  setRadio: (obj) ->
    obj = util._extend {type: "radio", select: false}, obj
    @setInput(obj)

  setSelect: (obj) ->
    _select = new Select obj
    @setField _select



  setField: (obj) ->
    obj._attributes.weight = @_weight += 10 if !obj._attributes.weight
    obj.parent = @
    @_attributes.fields.push obj
    @sort()
    obj

  sort: ()->
    @_attributes.fields = @_sort @_attributes.fields


  findByFid: (fid) ->
    fields = @_attributes.fields
    for key of fields
      _field = fields[key]
      return _field  if _field._attributes.fid is fid
      return _in_field  if _in_field = _field.findByFid(fid)  if _field._attributes.fields
    false




  toObject: ->
    _attributes = util._extend {}, @_attributes
    _fields = _attributes.fields

    _fields.forEach (item, key) ->
      _fields[key] = item.toObject()

    _attributes



module.exports = Fieldset

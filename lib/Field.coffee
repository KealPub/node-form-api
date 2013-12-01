util = require("util")

fields = 0

class Field
  constructor:(obj) ->

    @_attributes = {} if !@_attributes

    util._extend @_default, @default if @default
    util._extend @_attributes, @_default
    util._extend @_attributes, obj

    @_attributes.fid = "field-#{++fields}"

  toObject: ->
    @_attributes

  addClass: (_class) ->
    @_attributes.className += " #{_class}"
    @_attributes.className = trim(@_attributes.className)

  removeClass: (_class) ->
    @_attributes.className.replace(_class, "")
    @_attributes.className = trim(@_attributes.className)

  setWeight: (weigth) ->
    @_attributes.weight = weigth
    @parent.sort()

  _sort: (obj) ->
    if obj.length == 2 then return @_sortForTwoElement(obj)
    qsort obj,
      (a,b) ->
        (if (a._attributes.weight is b._attributes.weight) then 0 else ((if (a._attributes.weight > b._attributes.weight) then 1 else -1)))

  _sortForTwoElement: (obj) ->
    if(obj[0]._attributes.weight > obj[0]._attributes.weight)
      _temp = obj[0]._attributes.weight
      obj[0]._attributes.weight = obj[1]._attributes.weight
      obj[1]._attributes.weight = _temp

    obj

  _default:
    name: ""
    label: ""
    className: ""
    id: ""
    value: ""
    weight: 0


trim = (str) ->
  str = str.replace(/^\ /, "")
  str.replace(/\ $/, "")

#
# * Алгоритм быстрой сортировки
# *
# * @param data Array
# * @param compare function(a, b) - возвращает 0 если a=b, -1 если a<b и 1 если a>b (необязательная)
# * @param change function(a, i, j) - меняет местами i-й и j-й элементы массива а (необязательная)
# *
#
qsort = (data, compare, change) ->
  a = data
  f_compare = compare
  f_change = change
  # Данные не являются массивом
  return a  if not a instanceof Array or a.length < 3
  if !f_compare # Будем использовать простую функцию (для чисел)
    f_compare = (a, b) ->
      (if (a is b) then 0 else ((if (a > b) then 1 else -1)))
  if !f_change # Будем использовать простую смены (для чисел)
    f_change = (a, i, j) ->
      c = a[i]
      a[i] = a[j]
      a[j] = c
  qs = (l, r) ->
    i = l
    j = r
    x = a[l + r >> 1]

    while i <= j
      i++  while f_compare(a[i], x) is -1
      j--  while f_compare(a[j], x) is 1
      f_change a, i++, j--  if i <= j
    qs l, j  if l < j
    qs i, r  if i < r

  qs 0, a.length - 1

  return a

module.exports = Field

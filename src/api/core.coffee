underscore = require 'underscore'
$ = require '../cheerio'

size = exports.size = () ->
  this.length
  
toArray = exports.toArray = () ->
  return Array.prototype.slice.call this, 0

# Get the Nth element in the matched element set OR
# Get the whole matched element set as a clean array
get = exports.get = (num) ->
  if num is undefined
    this.toArray() 
  else
    if num < 0
      this[this.length + num] 
    else 
      this[num]

# Take an array of elements and push it onto the stack
# (returning the new matched element set)
pushStack = exports.pushStack = (elems, name, selector) ->
  ret = this.constructor()
  if $.isArray(elems)
    push.apply ret, elems
  else
    $.merge ret, elems
    
  ret.prevObject = this
  ret.context = this.context
  
  if name == "find"
    ret.selector = this.selector + (if this.selector then " " else "") + selector
  else 
    ret.selector = this.selector + "." + name + "(" + selector + ")"  if name
  
  return ret



siblingsAndMe = exports.siblingsAndMe = () ->
  siblings = []
  raw = this[0]

  element = raw
  while element.prev
    element = element.prev

  siblings.push element
  while element.next
    element = element.next
    siblings.push element
    
  return siblings  

module.exports = $.fn.extend exports
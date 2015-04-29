TodosModel = require "../models/TodosModel"

class TodosCollection extends Backbone.Collection
  
  url       : "todos"
  model     : TodosModel
  comparator: (todo) -> 
    return todo.get("order")
  
  localStorage: new Store("todos")
  
  getDone = (todo) -> 
    return todo.get("done")
  
  done: -> 
    return @filter( @getDone )
  
  remaining: -> 
    return @without.apply( this, @done() )
  
  nextOrder: -> 
    return 1 if !@length
    return @last().get("order") + 1
  
module.exports = TodosCollection
ToDoModel = require "../models/ToDoModel"

class TodoList extends Backbone.Collection
  
  # Reference to collection model
  url  : "toDo"
  model: ToDoModel
  comparator: (todo) -> return todo.get("order")
    
  # Save all of the todo 
  localStorage: new Store("todos")

  # Return attribute done
  getDone = (todo) ->
    return todo.get("done")
  
  # Filter the checked elements
  done: ->
    return @filter( getDone )

  # Filter the NON-checked elements in the list
  remaining: ->
    return @without.apply( this, @done() )

  # We keep the Todos in sequential order, despite being saved by unordered
  # GUID in the database. This generates the next order number for new items.
  nextOrder: ->
    return 1 if !@length
    return @last().get("order") + 1
  
module.exports = ToDoCollection
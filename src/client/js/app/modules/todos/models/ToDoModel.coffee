class Todo extends Backbone.Model
  
  # default attributes for the app
  defaults:
    content: "empty todo..."
    done   : false
  
  # Need to be sure that each todo has content
  initialize: ->
    if !@get("content")
       @set({ "content": @defaults.content })

  # Give the chance to toggle done, when the task is completed
  toggle: ->
    @save({ done: !@get("done") })

  # Remove and destroy the local file
  clear: ->
    @destroy()
    @view.remove()
    
module.exports = ToDoModel
ToDoCollection = require "../collections/ToDoCollection"

class ToDoView extends Marionette.ItemView
  
  # list tag
  tagName: "li"

  # Cache the template function for a single item
  template: _.template( $("#item-template").html() )
  
  # If there are changes in the model, the view is re-rendered
  # Direct reference to the model
  initialize: ->
    @model.bind("change", this.render);
    @model.view = this;

  # The DOM events specific to an item
  events:
    "click .check"             : "toggleDone",
    "dblclick div.todo-content": "edit",
    "click span.todo-destroy"  : "clear",
    "keypress .todo-input"     : "updateOnEnter"

  # Re-render the contents
  render: =>
    this.$(@el).html( @template(@model.toJSON()) )
    @setContent()
    return this

  # Using "jQuery.text" to set the contents of the todo item
  setContent: ->
    content = @model.get("content")
    this.$(".todo-content").text(content)
    @input = this.$(".todo-input");
    @input.bind("blur", @close);
    @input.val(content);

  # Toggle the "done" state of the model
  toggleDone: ->
    @model.toggle()

  # Switch this view into "editing" mode, displaying the input field
  edit: =>
    this.$(@el).addClass("editing")
    @input.focus()

  # Close the "editing" mode, displaying the input field
  close: =>
    @model.save({ content: @input.val() })
    $(@el).removeClass("editing")

  # Hit "enter" to edit the item
  updateOnEnter: (e) =>
    @close() if e.keyCode is 13

  # Remove the view from the DOM
  remove: ->
    $(@el).remove()

  # Remove the item, destroy the model
  clear: () ->
    @model.clear()
    
module.exports = ToDoView
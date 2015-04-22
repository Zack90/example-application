class AppView extends Marionette.View

  el_tag = "#todoapp"
  el: $(el_tag)

  statsTemplate: _.template( $("#stats-template").html() )

  events:
    "keypress #new-todo" : "createOnEnter",
    "keyup #new-todo"    : "showToolTip",
    "click .todo-clear a": "clearCompleted"

  initialize: =>
    @input = this.$("#new-todo")
    
    Todos.bind("add", @addOne)
    Todos.bind("reset", @addAll)
    Todos.bind("all", @render)

  render: =>
    this.$("#todo-stats").html( @statsTemplate({
      total    : Todos.length,
      done     : Todos.done().length,
      remaining: Todos.remaining().length
  }))
  
  addOne: (todo) =>
    view = new TodoView( {model: todo} )
    this.$("#todo-list").append( view.render().el )

  addAll: =>
    Todos.each(@addOne)

  newAttributes: ->
    return {
      content: @input.val(),
      order  : Todos.nextOrder(),
      done   : false
    }

  createOnEnter: (e) ->
    return if (e.keyCode != 13)
    Todos.create( @newAttributes() )
    @input.val("")

  clearCompleted: ->
    _.each(Todos.done(), (todo) ->
      todo.clear()
    )

  showTooltip: (e) ->
    tooltip = this.$(".ui-tooltip-top")
    val = @input.val()
    tooltip.fadeOut()
    clearTimeout(@tooltipTimeout) if (@tooltipTimeout)
    return if (val is "" || val is @input.attr("placeholder"))

    show = () ->
      tooltip.show().fadeIn()
    @tooltipTimeout = _.delay(show, 1000)

Todos = new TodoList
App   = new AppView()
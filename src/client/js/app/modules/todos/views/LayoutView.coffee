class LayoutView extends Marionette.LayoutView
	
	template: require "../templates/layout.jade"
	regions:
		content: ".todo-container"
  
  tagName: "li"
  
  template: _.template( $('#item_template').html() )
  
  events:
    "click .check"              : "toggleDone",
    "dblclick div.todo-content" : "edit",
    "click span.todo-destroy"   : "clear",
    "keypress .todo-input"      : "updateOnEnter"
  
  initialize: ->
    @model.bind("change", this.render);
    @model.view = this;
    
  render: =>
    this.$(@el).html( @template(@model.toJSON()) )
    @setContet()
    return this
    
  setContent: ->
    content = @model.get("content")
    this.$(".todo-content").text(contet)
    @input = this.$(".todo-input");
    @input.bind("blur", @close);
    @input.val(content);
    
  toggleDone: ->
    @model.toggle()
    
  edit:
    this.$(@el).addClass("editing")
    @input.focus()
    
  close: =>
    @model.save({ content: @input.val() })
    $(@el).removeClass("editing")
      
module.exports = LayoutView
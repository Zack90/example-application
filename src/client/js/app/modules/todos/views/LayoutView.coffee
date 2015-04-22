class LayoutView extends Marionette.LayoutView
	template: require "../templates/layout.jade"

	regions:
		content: ".todo-container"

	onBeforeShow: ->
		@getRegion("content").show new toDoView

module.exports = LayoutView
viewStyles = require('styles/ui/android').actionBar.action

BaseView = require 'views/base'

module.exports = class ActionView extends BaseView

  attributes: viewStyles.view

  events: { 'click' }

  click: =>
    @model.get('click')?(@model) if @model.get 'enabled'

  initialize: ->

    super

    @bindToAndTrigger @model, 'change:enabled', =>
      # @view.opacity = 1.0
      @view.opacity = if @model.get('enabled') then 1 else 0.5

    @modelBind 'change:text', =>

      if @labelView
        @labelView.text = @model.get 'text'
      else
        @render()

    @modelBind 'change:icon', @render

  render: =>

    if icon = @model.get 'icon'

      @view.add @iconView = @make 'ImageView', viewStyles.icon,
        image: icon

    else
      @view.remove @iconView if @iconView
      @iconView = null

    if text = @model.get 'text'

      @view.add @labelView = @make 'Label', viewStyles.label, { text }

    else
      @view.remove @labelView if @labelView
      @labelView = null

    @

  dispose: ->

    @labelView = null
    @iconView = null

    super

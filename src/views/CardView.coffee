class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '' 

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    if(@model.get 'revealed')
      @$el.css 
        "background" : "url(img/cards/#{@model.attributes.rankName}-#{@model.attributes.suitName}.png)"
        "background-size" : "contain"
    @$el.addClass 'covered' unless @model.get 'revealed'


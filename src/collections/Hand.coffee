class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    #if scores is less than 21, then hit 
    if @scores()[0] < 21
      result = @deck.pop()
      @add(result)
      result
    
  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  stand: ->   
    if @isDealer
      #stop the game and compare results
      @trigger 'gameOver',@
    else
      @trigger 'playerStand',@
      #trigger for dealer to go  --> #flip dealer card

  dealerHit: ->
    #dealer hits on soft 17, but stands on hard 17
    if @scores()[1] < 18 #soft 17
      @add(@deck.pop())
      @dealerHit()
    else if @scores()[0] < 17 and !(@scores()[1] > 17) #hard 17
      @add(@deck.pop())
      @dealerHit()
    else #stand
      @stand()

    #problem, if the dealer has 21 with an ace he will still hit


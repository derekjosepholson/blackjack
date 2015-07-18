# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.

class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    #listen for player stand
    @get('playerHand').on 'playerStand', ->
      console.log 
      @get('dealerHand').at(0).flip()
      @get('dealerHand').dealerHit()
    , @

    @get('dealerHand').on 'gameOver', ->
      dealerScore = @get('dealerHand').scores()[1]
      if dealerScore > 21
        dealerScore = @get('dealerHand').scores()[0]

      playerScore = @get('playerHand').scores()[1]
      if playerScore > 21
        playerScore = @get('playerHand').scores()[0]
      if playerScore > 21 and dealerScore > 21
        alert 'you both lose!'
      else if playerScore > dealerScore and playerScore < 22
        alert winner
        alert 'you win!'
      else if dealerScore > playerScore and dealerScore < 22
        alert 'you lost!'
      else if playerScore < 22 and dealerScore > 21
        alert 'you win!'
      else if dealerScore < 22 and playerScore > 21
        alert 'you lose!'
      else
        alert 'tie game!'

    , @
    
     
assert = chai.assert

describe 'deck', ->

  beforeEach ->
    
   

  it 'dealer goes over', ->
    model = new App()
    deck = new Deck()
    fiveCard = new Card({rank:5})
    tenCard = new Card({rank:10})
    fourCard = new Card({rank:4})
    twoCard = new Card ({rank:2})
    model.set 'playerHand', new Hand(tenCard, tenCard)
    model.set 'dealerHand', new Hand(twoCard,tenCard,tenCard)
    model.get('dealerHand').trigger('gameOver', model.get('dealerHand'))
    console.log model
    #model.get('dealerHand').stand()
    assert.equal(window.winner, 'you')
require 'test/unit'
load '../player.rb'
load '../game.rb'
load '../card.rb'
#require File.join(File.dirname(__FILE__), '..' ,'player.rb')
#require File.join(File.dirname(__FILE__), '..' ,'game.rb')


class WarTest < Test::Unit::TestCase


  def  new_players
      player1 = Player.new
      player2 = Player.new
      assert_equal(0, player1.has_how_many_cards)
      assert_equal(0, player2.has_how_many_cards)
  end


  def test_dealing_works

    game = Game.new(2,52)  # 2 players, deck of 52 cards
    assert_equal(2,game.players_in_game)
    player1  = game.player(0)
    player2  = game.player(1)
    game.deal

    assert_equal(26, player1.has_how_many_cards)
    assert_equal(26, player2.has_how_many_cards)
  end
  def test_force_hand_and_play
    #set up player1's hand to have a certain top card
    #set up player2's hand to have a different certain top card
    game = Game.new(2,0)
    player1  = game.player(0)
    player2  = game.player(1)
    player1.receives_a_card(Card.new(8,'spades'))
    player2.receives_a_card(Card.new(5,'clubs'))
    assert_equal(8,player1.play_a_card.value)
    assert_equal(5,player2.play_a_card.value)
    assert_equal(player1.has_how_many_cards,0)
    assert_equal(player2.has_how_many_cards,0)
  end



def test_round_with_clear_winner
    game = Game.new(2,0)
    player1  = game.player(0)
    player2  = game.player(1)
    player1.receives_a_card(Card.new(8,'spades'))
    player2.receives_a_card(Card.new(5,'clubs'))
    assert_equal(player1.has_how_many_cards,1)
    assert_equal(player2.has_how_many_cards,1)
    game.play_round
    #assert what player1 and player2's hand now looks like
    assert_equal(2,player1.has_how_many_cards)
    assert_equal(0,player2.has_how_many_cards)
end

def test_round_with_tie_then_winner
    game = Game.new(2,0)
    player1  = game.player(0)
    player2  = game.player(1)
    player1.receives_a_card(Card.new(3,'spades'))
    player2.receives_a_card(Card.new(3,'clubs'))
    game.play_round
    assert_equal(0,player1.has_how_many_cards)
    assert_equal(0,player2.has_how_many_cards)
    player1.receives_a_card(Card.new(4,'spades'))
    player2.receives_a_card(Card.new(8,'clubs'))
    game.play_round
    assert_equal(0,player1.has_how_many_cards)
    assert_equal(4,player2.has_how_many_cards)
end

def test_whole_deck
  game = Game.new(2,6)
  player1  = game.player(0)
  player2  = game.player(1)
  game.deal
  while player1.has_a_card? && player2.has_a_card?
    puts '-------'
    puts 'p1: '+ player1.cards
    puts 'p2: '+ player2.cards
    puts '-------'
    game.play_round

  end
  puts '-------'
  puts 'p1: '+ player1.cards
  puts 'p2: '+ player2.cards
  puts '-------'
  #assert_equal(0,player1.has_how_many_cards)
  #assert_equal(4,player2.has_how_many_cards)
end

end


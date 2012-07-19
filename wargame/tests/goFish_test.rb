require 'test/unit'
require_relative '../gf_player.rb'
require_relative '../gf_game.rb'
require_relative '../gf_card.rb'
#require File.join(File.dirname(__FILE__), '..' ,'player.rb')
#require File.join(File.dirname(__FILE__), '..' ,'game.rb')


class GoFishTest < Test::Unit::TestCase

  def test_ability_to_receive_cards
    title 'test_ability_to_receive_cards'
    how_many_players = 4
    number_of_cards = 0
    game = GfGame.new(how_many_players,number_of_cards)
    player1  = game.player(0)
    player2  = game.player(1)
    player3  = game.player(2)
    player4  = game.player(3)

    player1.load_hand(['A clubs','K clubs','2 clubs','4 clubs','5 clubs'])
    assert_equal(player1.has_how_many_cards,5)
    player2.load_hand(['A hearts','K hearts','2 hearts','4 hearts','5 hearts'])
    assert_equal(player2.has_how_many_cards,5)
    player3.load_hand(['A diamonds','K diamonds','2 diamonds','4 diamonds','5 diamonds'])
    assert_equal(player3.has_how_many_cards,5)
    player4.load_hand(['A spades','K spades','2 spades','4 spades','5 spades'])
    assert_equal(player4.has_how_many_cards,5)
  end

  def test_deal_delivers_cards
    title 'test_deal_delivers_cards'
    game = GfGame.new(4)
    player1  = game.player(0)
    player2  = game.player(1)
    player3  = game.player(2)
    player4  = game.player(3)

    game.deal

    assert_equal(player1.has_how_many_cards,5)
    assert_equal(player2.has_how_many_cards,5)
    assert_equal(player3.has_how_many_cards,5)
    assert_equal(player4.has_how_many_cards,5)
  end

  def test_player_knowledge_of_other_players_via_game_object
    title 'test_player_knowledge_of_other_players_via_game_object'
    game = GfGame.new(3)
    player1  = game.player(0)
    assert_equal(3,player1.parent_game.players_in_game)
    assert_equal(3,player1.parent_game.player(2).who_am_I)
  end

  def test_player_able_to_ask_a_specific_player_for_specific_card_held
    title 'test_player_able_to_ask_a_specific_player_for_specific_card_held'
    game = GfGame.new(3)
    player1  = game.player(0)
    player2  = game.player(1)
    player1.load_hand(['A clubs','K clubs','2 clubs','4 clubs','5 clubs'])
    player2.load_hand(['A hearts','K hearts','2 hearts','4 hearts','5 hearts'])
    assert(player1.ask_for?(player2,'A') )
  end

  def test_player_asks_and_receives_a_specific_card
    title 'test_player_asks_and_receives_a_specific_card'
    game = GfGame.new(3)
    player1  = game.player(0)
    player2  = game.player(1)
    player1.load_hand(['A clubs'])
    player2.load_hand(['A hearts'])
    player1.ask_for?(player2,'A')
    assert(player1.hand_has?('A hearts'))

  end

  def test_player_recognizes_legitimate_card_legitimate_player
    title 'test_player_recognizes_legitimate_card_legitimate_player'
    game = GfGame.new(4)
    player1  = game.player(0)
    player2  = game.player(1)
    player3  = game.player(2)
    player4  = game.player(3)
    player1.load_hand(['A clubs'])
    player2.load_hand(['A hearts'])
    player3.load_hand(['2 hearts'])
    player4.load_hand(['9 hearts'])
    assert_equal('A',player1.valid_rank_to_seek)
  end

  def test_player_asks_one_player_and_obtains_book_and_discards
    title 'test_player_asks_one_player_and_obtains_book_and_discards'
    game = GfGame.new(4)
    player1  = game.player(0)
    player2  = game.player(1)
    player3  = game.player(2)
    player4  = game.player(3)

    player1.load_hand(['A clubs'])
    player2.load_hand(['A hearts','A spades','A diamonds'])
    player3.load_hand(['5 hearts'])
    player4.load_hand(['6 hearts'])
    player1.play_till_end_of_turn
    assert_equal(0,player1.has_how_many_cards)
    assert_equal(1,player1.has_how_many_books)

  end

  def test_player_asks_several_other_players_and_obtains_book
    title 'test_player_asks_several_other_players_and_obtains_book'
    game = GfGame.new(4)
    player1  = game.player(0)
    player2  = game.player(1)
    player3  = game.player(2)
    player4  = game.player(3)
    player1.load_hand(['8 hearts','A clubs'])
    player2.load_hand(['A hearts','5 clubs'])
    player3.load_hand(['A spades', '9 diamonds'])
    player4.load_hand(['A diamonds', '10 spades'])
    assert_equal(2,player1.has_how_many_cards)
    assert_equal(2,player2.has_how_many_cards)
    assert_equal(2,player3.has_how_many_cards)
    assert_equal(2,player4.has_how_many_cards)
    player1.play_till_end_of_turn
    assert_equal(1,player1.has_how_many_cards)
    assert_equal(1,player1.has_how_many_books)

  end

  def test_player_asks_without_fullfillment_and_goes_fishing
    title 'test_player_asks_without_fullfillment_and_goes_fishing'
    game = GfGame.new(4)
    player1  = game.player(0)
    player2  = game.player(1)
    player3  = game.player(2)
    player4  = game.player(3)
    player1.load_hand(['4 clubs'])
    player2.load_hand(['A hearts'])
    player3.load_hand(['A spades'])
    player4.load_hand(['A diamonds'])
    player1.play_till_end_of_turn
    assert_equal(2,player1.has_how_many_cards)
    assert_equal(1,player2.has_how_many_cards)
    assert_equal(1,player3.has_how_many_cards)
    assert_equal(1,player4.has_how_many_cards)
  end

  def test_player_goes_fishing_and_finds_so_continues
    title 'test_player_goes_fishing_and_finds_so_continues'
    game = GfGame.new(4)
    player1  = game.player(0)
    player2  = game.player(1)
    player3  = game.player(2)
    player4  = game.player(3)
    player1.load_hand(['4 clubs'])
    player2.load_hand(['3 hearts','9 hearts'])
    player3.load_hand(['2 spades'])
    player4.load_hand(['3 diamonds'])
    game.deck.load_with(['4 diamonds'])
    player1.play_till_end_of_turn
    assert_equal(3,player1.has_how_many_cards)
    assert_equal(2,player2.has_how_many_cards)
    assert_equal(1,player3.has_how_many_cards)
    assert_equal(1,player4.has_how_many_cards)
    assert(player1.hand_has?('4 clubs'))
    assert(player1.hand_has?('4 diamonds'))
  end

  def test_player_fishes_without_success_and_surrenders_turn_to_another
    title 'test_player_fishes_without_success_and_surrenders_turn_to_another'
    game = GfGame.new(4)
    player1  = game.player(0)
    player2  = game.player(1)
    player3  = game.player(2)
    player4  = game.player(3)
    player1.load_hand(['9 clubs'])
    player2.load_hand(['A hearts'])
    player3.load_hand(['A spades'])
    player4.load_hand(['A diamonds'])
    game.deck.load_with(['4 diamonds'])
    player1.play_till_end_of_turn
    assert_equal(2,player1.has_how_many_cards)
    assert_equal(1,player2.has_how_many_cards)
    assert_equal(1,player3.has_how_many_cards)
    assert_equal(1,player4.has_how_many_cards)
    assert_equal(1,game.current_player)
  end

  def test_end_game_when_no_more_cards_in_deck
    game = GfGame.new(4)
    player1  = game.player(0)
    player2  = game.player(1)
    player3  = game.player(2)
    player4  = game.player(3)
    player1.load_hand(['A clubs'])
    player2.load_hand(['4 hearts'])
    player3.load_hand(['2 spades'])
    player4.load_hand(['3 diamonds'])
    assert_not_equal(0,game.deck.has_how_many_cards)
    assert_not_equal(true,game.game_over?)
    assert_equal(52,game.deck.has_how_many_cards)
    game.deck.initialize_deck([])
    game.deck.load_with(['A diamonds'])
    player1.play_till_end_of_turn
    assert_equal(2,player1.has_how_many_cards)
    assert_equal(1,player2.has_how_many_cards)
    assert_equal(1,player3.has_how_many_cards)
    assert_equal(1,player4.has_how_many_cards)
    assert_equal(true,game.game_over?)
  end

  def test_end_game_when_one_person_has_no_cards
    title 'test_end_game_when_one_person_has_no_cards'
    game = GfGame.new(4)
    player1  = game.player(0)
    player2  = game.player(1)
    player3  = game.player(2)
    player4  = game.player(3)
    player1.load_hand(['A clubs'])
    player2.load_hand(['A hearts'])
    player3.load_hand(['2 spades'])
    player4.load_hand(['3 diamonds'])
    assert_not_equal(true,game.game_over?)
    player1.play_till_end_of_turn
    assert_equal(2,player1.has_how_many_cards)
    assert_equal(0,player2.has_how_many_cards)
    assert_equal(1,player3.has_how_many_cards)
    assert_equal(1,player4.has_how_many_cards)
    assert_equal(52,game.deck.has_how_many_cards)
    assert_equal(true,game.game_over?)

  end

  def test_scoring


  end

  def title(x)
    puts '============================================================'
    puts x
  end

end


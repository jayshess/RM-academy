#require 'spec_helper'   # for rails
load 'gf_player.rb'
load 'gf_game.rb'
load 'gf_card.rb'


 describe 'Go Fish' do

   describe 'Go Fish 1' do
     it 'tests_ability_to_receive_cards' do
       how_many_players = 4
       number_of_cards = 0
       game = GfGame.new(how_many_players, number_of_cards)
       player1 = game.player(0)
       player2 = game.player(1)
       player3 = game.player(2)
       player4 = game.player(3)

       player1.load_hand(['A clubs', 'K clubs', '2 clubs', '4 clubs', '5 clubs'])
       player1.has_how_many_cards.should equal 5
       #assert_equal(player1.has_how_many_cards,5)
       player2.load_hand(['A hearts', 'K hearts', '2 hearts', '4 hearts', '5 hearts'])
       assert_equal(player2.has_how_many_cards, 5)
       player3.load_hand(['A diamonds', 'K diamonds', '2 diamonds', '4 diamonds', '5 diamonds'])
       assert_equal(player3.has_how_many_cards, 5)
       player4.load_hand(['A spades', 'K spades', '2 spades', '4 spades', '5 spades'])
       assert_equal(player4.has_how_many_cards, 5)
     end
   end

   describe 'dealing' do
     it 'test_deal_delivers_cards' do
       game = GfGame.new(4)
       player1 = game.player(0)
       player2 = game.player(1)
       player3 = game.player(2)
       player4 = game.player(3)

       game.deal

       assert_equal(player1.has_how_many_cards, 5)
       assert_equal(player2.has_how_many_cards, 5)
       assert_equal(player3.has_how_many_cards, 5)
       assert_equal(player4.has_how_many_cards, 5)
     end
   end

   describe 'test_player_knowledge_of_other_players_via_game_object' do
     it 'test_player_knowledge_of_other_players_via_game_object' do
       game = GfGame.new(3)
       player1 = game.player(0)
       assert_equal(3, player1.parent_game.players_in_game)
       assert_equal(2, player1.parent_game.player(2).who_am_I)
     end
   end

   describe 'test_player_able_to_ask_a_specific_player_for_specific_card_held' do
     it 'test_player_able_to_ask_a_specific_player_for_specific_card_held' do
       game = GfGame.new(3)
       player1 = game.player(0)
       player2 = game.player(1)
       player1.load_hand(['A clubs', 'K clubs', '2 clubs', '4 clubs', '5 clubs'])
       player2.load_hand(['A hearts', 'K hearts', '2 hearts', '4 hearts', '5 hearts'])
       assert(player1.ask_for?(player2, 'A'))
     end
   end

   describe 'test_player_asks_and_receives_a_specific_card' do
     it 'test_player_asks_and_receives_a_specific_card' do
       game = GfGame.new(3)
       player1 = game.player(0)
       player2 = game.player(1)
       player1.load_hand(['A clubs'])
       player2.load_hand(['A hearts'])
       player1.ask_for?(player2, 'A')
       assert(player1.hand_has?('A hearts'))
     end
   end

   describe 'test_player_recognizes_legitimate_card_legitimate_player' do
     it 'test_player_recognizes_legitimate_card_legitimate_player' do
       game = GfGame.new(4)
       player1 = game.player(0)
       player2 = game.player(1)
       player3 = game.player(2)
       player4 = game.player(3)
       player1.load_hand(['A clubs'])
       player2.load_hand(['A hearts'])
       player3.load_hand(['2 hearts'])
       player4.load_hand(['9 hearts'])
       player1.valid_rank_to_seek().should eq "A"
     end
   end

   describe 'test_player_asks_one_player_and_obtains_book_and_discards' do
     it 'test_player_asks_one_player_and_obtains_book_and_discards' do
       game = GfGame.new(4)
       player1 = game.player(0)
       player2 = game.player(1)
       player3 = game.player(2)
       player4 = game.player(3)

       player1.load_hand(['A clubs'])
       player2.load_hand(['A hearts', 'A spades', 'A diamonds'])
       player3.load_hand(['5 hearts'])
       player4.load_hand(['6 hearts'])
       player1.play_till_end_of_turn
       assert_equal(0, player1.has_how_many_cards)
       assert_equal(1, player1.has_how_many_books)
     end
   end

   describe 'test_player_asks_several_other_players_and_obtains_book' do
     it 'test_player_asks_several_other_players_and_obtains_book' do
       game = GfGame.new(4,0)
       player1 = game.player(0)
       player2 = game.player(1)
       player3 = game.player(2)
       player4 = game.player(3)
       player1.load_hand(['A clubs', '8 hearts'])
       player2.load_hand(['A hearts', '5 clubs'])
       player3.load_hand(['A spades', '9 diamonds'])
       player4.load_hand(['A diamonds', '10 spades'])
       game.deck.load_with(['2 diamonds'])
       assert_equal(2, player1.has_how_many_cards)
       assert_equal(2, player2.has_how_many_cards)
       assert_equal(2, player3.has_how_many_cards)
       assert_equal(2, player4.has_how_many_cards)
       player1.play_till_end_of_turn
       assert_equal(2, player1.has_how_many_cards)
       assert_equal(1, player1.has_how_many_books)
     end
   end

   describe 'test_player_asks_without_fullfillment_and_goes_fishing' do
     it 'test_player_asks_without_fullfillment_and_goes_fishing' do
       game = GfGame.new(4)
       player1 = game.player(0)
       player2 = game.player(1)
       player3 = game.player(2)
       player4 = game.player(3)
       player1.load_hand(['4 clubs'])
       player2.load_hand(['A hearts'])
       player3.load_hand(['A spades'])
       player4.load_hand(['A diamonds'])
       game.deck.load_with(['5 diamonds'])
       player1.play_till_end_of_turn
       assert_equal(2, player1.has_how_many_cards)
       assert_equal(1, player2.has_how_many_cards)
       assert_equal(1, player3.has_how_many_cards)
       assert_equal(1, player4.has_how_many_cards)
     end
   end

   describe 'test_player_goes_fishing_and_finds_so_continues' do
     it 'test_player_goes_fishing_and_finds_so_continues' do
       game = GfGame.new(4)
       player1 = game.player(0)
       player2 = game.player(1)
       player3 = game.player(2)
       player4 = game.player(3)
       player1.load_hand(['4 clubs'])
       player2.load_hand(['3 hearts', '9 hearts'])
       player3.load_hand(['2 spades'])
       player4.load_hand(['3 diamonds'])
       game.deck.load_with(['A hearts','4 diamonds'])
       player1.play_till_end_of_turn
       assert_equal(3, player1.has_how_many_cards)
       assert_equal(2, player2.has_how_many_cards)
       assert_equal(1, player3.has_how_many_cards)
       assert_equal(1, player4.has_how_many_cards)
       assert(player1.hand_has?('4 clubs'))
       assert(player1.hand_has?('4 diamonds'))
     end
   end

  describe 'test_player_fishes_without_success_and_surrenders_turn_to_another' do
    it 'test_player_fishes_without_success_and_surrenders_turn_to_another' do
      game = GfGame.new(4)
      player1 = game.player(0)
      player2 = game.player(1)
      player3 = game.player(2)
      player4 = game.player(3)
      player1.load_hand(['9 clubs'])
      player2.load_hand(['A hearts'])
      player3.load_hand(['A spades'])
      player4.load_hand(['A diamonds'])
      game.deck.load_with(['4 diamonds'])
      player1.play_till_end_of_turn
      assert_equal(2, player1.has_how_many_cards)
      assert_equal(1, player2.has_how_many_cards)
      assert_equal(1, player3.has_how_many_cards)
      assert_equal(1, player4.has_how_many_cards)
      assert_equal(1, game.current_player)
    end
  end

  describe 'test_end_game_when_no_more_cards_in_deck' do
    it 'test_end_game_when_no_more_cards_in_deck' do
      game = GfGame.new(4)
      player1 = game.player(0)
      player2 = game.player(1)
      player3 = game.player(2)
      player4 = game.player(3)
      player1.load_hand(['A clubs'])
      player2.load_hand(['4 hearts'])
      player3.load_hand(['2 spades'])
      player4.load_hand(['3 diamonds'])
      assert_not_equal(0, game.deck.has_how_many_cards)
      assert_not_equal(true, game.go_fish_over?)
      assert_equal(52, game.deck.has_how_many_cards)
      game.deck.initialize_deck([])
      game.deck.load_with(['A diamonds'])
      player1.play_till_end_of_turn
      assert_equal(2, player1.has_how_many_cards)
      assert_equal(1, player2.has_how_many_cards)
      assert_equal(1, player3.has_how_many_cards)
      assert_equal(1, player4.has_how_many_cards)
      assert_equal(true, game.go_fish_over?)
    end
  end

  describe 'test_end_game_when_one_person_has_no_cards' do
    it 'test_end_game_when_one_person_has_no_cards' do
      game = GfGame.new(4)
      player1 = game.player(0)
      player2 = game.player(1)
      player3 = game.player(2)
      player4 = game.player(3)
      player1.load_hand(['A clubs'])
      player2.load_hand(['A hearts'])
      player3.load_hand(['2 spades'])
      player4.load_hand(['3 diamonds'])
      assert_not_equal(true, game.go_fish_over?)
      player1.play_till_end_of_turn
      assert_equal(2, player1.has_how_many_cards)
      assert_equal(0, player2.has_how_many_cards)
      assert_equal(1, player3.has_how_many_cards)
      assert_equal(1, player4.has_how_many_cards)
      assert_equal(52, game.deck.has_how_many_cards)
      assert_equal(true, game.go_fish_over?)
    end
  end

 def assert_equal(a,b)
   b.should == a
 end

 def assert(s)
   s.should == true
 end

  def assert_not_equal(a,b)
    b.should_not == a
  end
end





#require File.join(File.dirname(__FILE__), '.' ,'deck_of_cards.rb')
#require File.join(File.dirname(__FILE__), '.' ,'player.rb')
load '../deck_of_cards.rb'
load '../player.rb'

class Game

  def players_in_game
    @players.size
  end

  def initialize (total_number_of_players, number_of_cards_in_deck)
    @deck = DeckOfCards.new number_of_cards_in_deck
    @discarded = []
    @players =[]
      total_number_of_players.times do
        @players << Player.new
    end
  end

  def deal
    which_player = 0
    while @deck.has_cards?
      @players[which_player%players_in_game].receives_a_card(@deck.get_next)
      which_player +=1
    end
  end

  attr_accessor :deck


  def play_round
    return nil unless players_in_game==2  #temporary guard until code can handle general case

    player_object_1 = @players[0]
    player_object_2 = @players[1]
    card_object_1 = player_object_1.play_a_card
    card_object_2 = player_object_2.play_a_card
    @discarded = @discarded << card_object_1
    @discarded = @discarded << card_object_2
    if card_object_1== card_object_2 then return nil end
    if card_object_1 > card_object_2
      player_object_1.add_array_to_hand(@discarded)
    else
      player_object_2.add_array_to_hand(@discarded)
    end
    @discarded=[]
  end

  def player (i)
    @players[i]
  end

  def index_of_this_player(n)
    n-1
  end

  def player (whole_number)
     @players[index_of_this_player(whole_number)]
  end

end
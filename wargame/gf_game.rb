
#require File.join(File.dirname(__FILE__), '.' ,'deck_of_cards.rb')
#require File.join(File.dirname(__FILE__), '.' ,'player.rb')
load '../gf_deck_of_cards.rb'
load '../gf_player.rb'
load '../game.rb'

class GfGame < Game
  attr_accessor :deck, :players

  def initialize (total_number_of_players, number_of_cards_in_deck=52)
    @deck = GfDeckOfCards.new number_of_cards_in_deck
    @players =[]
    player_id = 1
    total_number_of_players.times do
      @players << GfPlayer.new(player_id,self)
      player_id +=1
    end
  end



  def deal
    5.times { @players.each {|a_player| a_player.receives_a_card(@deck.get_next)}    }
  end

  def exercise_a_player(player_identifier) # >0
    @whose_turn = player_identifier
    while true
      player(@whose_turn).play
      break if go_fish_over?
      @whose_turn =  next_player_identifier
    end
    score
  end

  def next_player_identifier
    ((index_of_this_player(@whose_turn)+1)%players_in_game)+1
  end

  def game_over?
    all_players_in_play = true
    @players.each do |this_player|
      all_players_in_play = all_players_in_play && this_player.has_a_card?
    end
    !all_players_in_play || !@deck.has_cards?

  end

  def score
    0
  end




end
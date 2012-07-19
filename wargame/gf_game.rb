
#require File.join(File.dirname(__FILE__), '.' ,'deck_of_cards.rb')
#require File.join(File.dirname(__FILE__), '.' ,'player.rb')
require_relative 'gf_deck_of_cards.rb'
require_relative 'gf_player.rb'
require_relative 'game.rb'

class GfGame < Game
  attr_accessor :deck, :players , :current_player

  def initialize (total_number_of_players, number_of_cards_in_deck=52)
    @deck = GfDeckOfCards.new number_of_cards_in_deck
    @players =[]
    @current_player =0
    player_id = 0
    total_number_of_players.times do
      @players << GfPlayer.new(player_id,self)
      player_id +=1
    end
    say ">>>>> new Game <<<<<<"
  end


  def setup_and_go
     deal
     start_game
  end

  def deal (to_each=5)
    to_each.times { @players.each {|a_player| a_player.receives_a_card(@deck.get_next)}    }
  end


  def start_game(player_identifier=current_player)
    say "**** starting game"
    set_current_player(player_identifier)
    while !go_fish_over?
      players[@current_player].play_till_end_of_turn #each player hands over to next player
    end
    score
    puts ">>>>>> game over"
  end

  def set_current_player (id=nil)
    if @current_player == nil then @current_player=0
    else
      if id==nil || id=='' then
        @current_player =  next_player_identifier
      else @current_player = id
      end
    end
    say "set current player =  #{@current_player}"
  end

  def next_player_identifier
    x=((current_player+1)%players_in_game)
    say "next player = #{x}"
    x
  end

  def go_fish_over?
    all_players_in_play = true
    @players.each do |this_player|
      all_players_in_play = all_players_in_play && this_player.has_a_card?
    end
    !all_players_in_play || !@deck.has_cards?
  end

  def score
    0
  end

  def say(x)
    puts x
  end


end
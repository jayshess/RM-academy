
load 'gf_player.rb'
load 'gf_game.rb'
load 'gf_card.rb'

class GoFishUi

  attr_reader :game , :players

  def initialize (num_of_players, num_of_cards=52)
    @game = GfGame.new(4,num_of_cards)
    @players = @game.players

  end

  def set_player(id, type)
     players[id].ui_type = type
  end

  def start
    game.setup_and_go
  end

end
require 'test/unit'
require_relative '../go_fish_ui.rb'

#require_relative ''

class ModelDrivesUiTest < Test::Unit::TestCase

  def setup
    ui = GoFishUi.new(4)
    game = ui.game
  end

  def test_command_line_ui_can_display_cards
    game.ui_player(0).command_line
  end

  def test_command_line_ui_can_ask_player_n_for_rank
    game.ui_player(0).command_line
  end

end
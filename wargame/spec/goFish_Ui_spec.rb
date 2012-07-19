
load 'gf_player.rb'
load 'gf_game.rb'
load 'gf_card.rb'
load 'go_fish_ui.rb'
#rspec spec/goFish_Ui_spec.rb

describe 'Go Fish with UI' do

    #fish_ui.game.setup_and_go

  describe 'initial load of game' do
    before (:each) do
      @fish_UI = GoFishUi.new(4, 0)
      @fish_UI.set_player(0, 'commandline')
      @fish_UI.set_player(1, 'robot')
      @fish_UI.set_player(2, 'robot')
      @fish_UI.set_player(3, 'robot')
    end

    it 'should have 4 players' do
      @fish_UI.game.players.size.should equal(4)
    end


    it 'load players and deck with cards' do
      player1 = @fish_UI.game.player(0)
      player2 = @fish_UI.game.player(1)
      player3 = @fish_UI.game.player(2)
      player4 = @fish_UI.game.player(3)
      player1.load_hand(['A clubs', '8 hearts'])
      player2.load_hand(['A hearts', '5 clubs'])
      player3.load_hand(['A spades', '9 diamonds'])
      player4.load_hand(['A diamonds', '10 spades'])
      player1.has_how_many_cards.should == 2
      player2.has_how_many_cards.should == 2
      player3.has_how_many_cards.should == 2
      player4.has_how_many_cards.should == 2
      @fish_UI.game.deck.load_with(['6 hearts', '4 diamonds'])
      @fish_UI.game.deck.has_how_many_cards.should == 2
      @fish_UI.game.current_player.should == 0
      @fish_UI.game.start_game
      player1.has_how_many_cards.should == 2
      player1.has_how_many_books.should == 1
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
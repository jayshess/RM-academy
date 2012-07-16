load '../gf_card.rb'
load '../player.rb'

class GfPlayer < Player



  attr_reader :parent_game, :who_am_I, :my_cards

  def initialize (my_number,*game)
     @who_am_I = my_number
     @my_cards = []
     @parent_game = game[0] if game.size==1
   end

   def players
      @parent_game.players
   end

  def other_players
    players.reject {|p| p.who_am_I==who_am_I}
  end

  def ask_for(player_object,rank)
    reply = player_object.give_cards(rank)
    return false if reply.empty?
    reply.each {|card| add_to_hand(card) }
    true
  end

  def array_of_cards_with_rank(rank)
     my_cards.select {|card| card.has_rank?(rank)}
  end



  def add_to_hand(card_object)
    my_cards.unshift(card_object)
    make_a_book?
  end

  def hand_has?(one_card_string)
    test_card = GfCard.new(one_card_string)
    return !(my_cards.select {|a_card| a_card.equivalent_to(test_card)}).empty?
  end


  def play_till_end_of_turn
    @deck = @parent_game.deck
    return false unless !game_over?

    card_ptr = 0
    while collect_card_from_others_and_guess_again?(my_cards[card_ptr].rank) && (card_ptr < my_cards.size)
      seeking = my_cards[card_ptr].rank
      card_ptr +=1     no
    end
    go_fish_and_guess_again?(seeking)   no
  end

  def collect_card_from_others_and_guess_again?(card_rank)     no
    stopped = false
    made_a_book = false
    other_player_ptr = 0
    while (other_player_ptr < other_players.size) && !made_a_book
      cards_wanted = other_players[other_player_ptr].array_of_cards_with_rank(card_rank)
      other_player_ptr += 1
      stopped = cards_wanted.empty?
      break if stopped
      made_a_book = add_to_hand(cards_wanted)
    end
    return made_a_book || !stopped
  end


  def game_over?
    all_players_in_play = true
    players.each do |this_player|
      all_players_in_play = all_players_in_play && this_player.has_a_card?
    end
    !all_players_in_play || !@deck.has_cards?
  end


  def load_hand (array_of_card_names)
    array_of_card_names.each {|name| @my_cards << GfCard.new(name)}
  end


  def go_fish_and_guess_again? (rank_to_seek)
    card = @deck.get_next
    add_to_hand(card)
    (card.rank==rank_to_seek )
  end


end
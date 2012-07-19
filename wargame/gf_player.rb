require_relative 'gf_card.rb'
require_relative 'player.rb'

class GfPlayer < Player

  attr_reader :parent_game, :who_am_I,  :deck , :other_players
  attr_accessor :my_cards, :my_books  ,:ui_type , :last_card_used, :current_card_used

  def initialize (my_number,*game)
    @who_am_I = my_number
    @my_cards = []
    @parent_game = game[0] if game.size==1
    @my_books = []
    @last_card_used = nil
    @current_card_used = nil
    @card_ptr = 0
   end

   def players
      @parent_game.players
   end

  def set_other_players
    @other_players = players.reject {|p| p.who_am_I==who_am_I}
  end


  def remove_a_card(card_object)
    say "removing #{card_object.to_s} from player #{who_am_I}"
    my_cards.reject! {|a_card| a_card.equivalent_to(card_object)}
  end


  def ask_for?(player_object,rank)
    say 'ask player ' + player_object.who_am_I.to_s + " for " + rank.to_s
    reply = player_object.give_array_of_cards_with_rank(rank)
    return false if reply.empty?
    say '... and was given ' + reply.size.to_s + ' cards'
    reply.each {|card| add_to_hand(card) }
    true
  end

  def give_array_of_cards_with_rank(rank)
    reply = my_cards.select {|card| card.has_rank?(rank)}
    my_cards.reject! {|card| card.has_rank?(rank)}
    reply.each {|card| remove_a_card(card)}
    reply
  end


  def add_array_to_hand(card_array)
    return false if card_array.empty?
    card_array.each {|card| add_to_hand(card)}
  end

  def add_to_hand(card_object)
    return false if card_object == nil
    say "adding to hand: #{card_object.to_s} for player #{who_am_I}"
    my_cards.push(card_object)
    make_a_book
  end

  def hand_has?(one_card_string)
    test_card = GfCard.new(one_card_string)
    return !(my_cards.select {|a_card| a_card.equivalent_to(test_card)}).empty?
  end


  def play_till_end_of_turn
    say '>>>>play until end of turn'
    say "I am player #{who_am_I}"
    parent_game.set_current_player unless parent_game.current_player
    set_other_players
    say 'there are '+ other_players.size.to_s + ' other players'
    @deck = parent_game.deck

    players.each { |pla| say "player #{pla.who_am_I} has #{pla.has_how_many_cards} cards" }

    other_player_ptr = 0
    while !game_over?
      seeking = valid_rank_to_seek(current_card_used)
      ask_again = nil
      say "next player to ask is player #{other_player_ptr}"
      if !(ask_again=ask_for?(other_players[other_player_ptr], seeking))
        say 'request failed so need to go fish'
        ask_again = go_fish_and_guess_again?(seeking)
      end
      say "I can #{(ask_again)?'':'NOT'} ask again"
      #say 'after asking (and? fishing?) ... can I ask again? ' + ask_again.to_s
      break if !ask_again
      #strategy ...
      other_player_ptr += 1
      if other_player_ptr == other_players.size
        say 'start over with who to ask'
        pick_a_different_card
        other_player_ptr = 0
      end
      say "next player to ask is player #{other_player_ptr}"
    end
    say show_hand
    say ">>>>end of play till end for player #{who_am_I}"
    parent_game.set_current_player
  end

  def valid_rank_to_seek(card=nil)
    card = my_cards.first if card == nil
    say "seeking a friend for card #{card.to_s}"
    card.rank
  end

  def pick_a_different_card
    x= next_card
    say "next card to use is #{x.to_s}"
    x
  end

  def next_card
    best = my_cards.reject{|c| c.equivalent_to(current_card_used) || c.equivalent_to(last_card_used) }.first
    return best if best!= nil
    next_best = my_cards.reject{|c| c.equivalent_to(current_card_used) }.first
    return next_best if next_best!=nil
    my_cards.first
  end

  def make_a_book
     say 'player ' + who_am_I.to_s + ' checking for a book'
    rank_count = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

    my_cards.each {|card| rank_count[card.rank_to_num] += 1}
    my_cards_ptr = 0
    book_list = []
    while my_cards_ptr < my_cards.size
      a_card = my_cards[my_cards_ptr]
      say " .. checking card number  #{my_cards_ptr} is #{a_card.to_s} and is 1 among #{rank_count[a_card.rank_to_num]} like it"
      book_list << a_card if rank_count[a_card.rank_to_num]==4
      my_cards_ptr +=1
    end
    return if book_list.empty?
    book_list.each {|card| remove_a_card(card)}
    add_array_of_book(book_list)
  end

  def add_array_of_book(book_list)
    say("about to add array of book with #{book_list.size.to_s} elements")
    say( "booksize before= #{has_how_many_books.to_s}" )
    my_books.unshift(book_list)
    say('booksize after='+ has_how_many_books.to_s)
  end


  def has_how_many_books
     my_books.size
  end

  def game_over?
    all_players_in_play = true
    players.each { |this_player|
      all_players_in_play = all_players_in_play && this_player.has_a_card?
    }
    !all_players_in_play || !deck.has_cards?
  end


  def load_hand (array_of_card_names)
    say 'load a hand with array of ' + array_of_card_names.size.to_s + ' cards'
    array_of_card_names.each {|name| say '   adding '+ name; add_to_hand(GfCard.new(name))}
  end


  def go_fish_and_guess_again? (rank_to_seek)
    card = deck.get_next
    add_to_hand(card)
    (card.rank==rank_to_seek )
  end

  def show_hand
    say "Player #{who_am_I} has these #{my_cards.size} cards:"
    hand = ''
    my_cards.each {|c| hand += ' '+ c.to_s}
    hand
  end

  def say(x)
    puts x
  end




end
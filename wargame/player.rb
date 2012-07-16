class Player

  def initialize
    @my_cards = []
  end

  def play_a_card
    return nil if (has_how_many_cards == 0)
    @my_cards.pop
  end

  def receives_a_card (card_object)
    @my_cards << card_object
  end

  def has_how_many_cards
     @my_cards.size
  end

  def has_a_card?
    has_how_many_cards>0
  end

  def add_array_to_hand(array_of_card_objects)
    @my_cards = array_of_card_objects << @my_cards
    @my_cards.flatten!
  end

  def cards
    card_msg = ''
    @my_cards.each do |a_card|
      card_msg += '['+a_card.value.to_s + ' ' + a_card.suit + ']'
    end
    card_msg
  end

end
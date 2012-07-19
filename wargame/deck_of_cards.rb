#require File.join(File.dirname(__FILE__), '.' ,'card.rb')
require_relative 'card.rb'


class DeckOfCards

  def initialize_deck (array)
    if array.empty? then @all_cards=[]
    else @all_cards=array
    end
  end

  def initialize (total_number_cards) # how many to put into a deck
    @all_cards = []

    suits = %w(hearts clubs spades diamonds)
    suit_counter = 0
    card_value = 1
    while @all_cards.size < total_number_cards && card_value <= 13
      @all_cards << Card.new(card_value,suits[suit_counter])
      suit_counter = (suit_counter+1)%(suits.size)
      card_value +=1 if suit_counter ==0
    end
    @all_cards.shuffle!
  end

  def get_next
     @all_cards.pop
  end

  def has_cards?
     @all_cards.size > 0
  end

  def has_how_many_cards
    @all_cards.size
  end

  def load_with (array_of_card_names)
    array_of_card_names.each {|name| @all_cards << Card.new(name)}
  end

end
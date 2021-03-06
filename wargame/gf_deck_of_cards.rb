#require File.join(File.dirname(__FILE__), '.' ,'card.rb')
require_relative 'gf_card.rb'
require_relative 'deck_of_cards.rb'

class GfDeckOfCards < DeckOfCards

  def initialize (total_number_cards) # how many to put into a deck
    @all_cards = []
    ranks = %w(2 3 4 5 6 7 8 9 10 J Q K A)
    suits = %w(hearts clubs spades diamonds)
    suit_counter = 0
    rank_index = 0
    while @all_cards.size < total_number_cards && rank_index < 13
      @all_cards << GfCard.new(ranks[rank_index] + ' ' + suits[suit_counter])
      suit_counter = (suit_counter+1)%(suits.size)
      rank_index +=1 if suit_counter ==0
    end
    @all_cards.shuffle!
  end


  def load_with (array_of_card_names)
      say "Loading deck with ..."
    array_of_card_names.each {|name| say name; @all_cards << GfCard.new(name)}
  end

  def say(x)
    puts x
  end
end
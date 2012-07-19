
#load '../card.rb'
require_relative 'card.rb'

class GfCard < Card


  def initialize (name)
    @rank, @suit = name.split
  end

  attr_reader :rank

  def ranks
    @@ranks
  end

  def has_rank?(test_rank)
     rank == test_rank
  end

  def rank_to_num
    (ranks.index(rank)+2)
  end

  def equivalent_to other
    return true if self==nil && other == nil
    return false if self == nil || other == nil
    rank == other.rank && suit == other.suit
  end

  def to_s
    "#{rank} - #{suit}"
  end

end

load '../card.rb'

class GfCard < Card


  def initialize (name)
    @rank, @suit = name.split
  end

  attr_reader :rank


  def has_rank?(test_rank)
     rank == test_rank
  end

  def xits_text_value
    (ranks.index(rank)+2)
  end

  def equivalent_to other
    return super == other unless other.class == self.class
    rank == other.rank && suit == other.suit
  end


end
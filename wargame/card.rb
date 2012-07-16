
class Card

  @@ranks = %w(2 3 4 5 6 7 8 9 10 J Q K A)

  attr_reader :ranks, :suit

  def initialize (in_value, in_suit)
    @value = in_value
    @suit = in_suit
  end

  def value
    @value
  end

  def suit
    @suit
  end

  def rank
    @@ranks[value]
  end

  def > other
    value > other.value
  end

  def == other
    return super == other unless other.class == self.class
    value == other.value
  end

end
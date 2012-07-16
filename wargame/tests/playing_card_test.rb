
require 'test/unit'
load '../card.rb'

class PlayingCardTest < Test::Unit::TestCase
  def test_equals
    ace_spades = Card.new(13,'spades')
    ace_spades_2 = Card.new(13,'spades')
    assert_equal(ace_spades, ace_spades_2)
    two_spades = Card.new(1,'spades')
    two_clubs = Card.new(1,'clubs')
    assert_not_equal(two_spades,two_clubs)
    assert_not_equal(two_spades,'x')
    assert(ace_spades.equiv(ace_spades_2))

    assert(two_spades.equiv(two_clubs))
  end

end
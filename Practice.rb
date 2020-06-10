# class DiceSet2
#   attr_reader :values
#   @values = []
#   def roll(num)
#     i = 0
#     while i < num
#       @values << (1 + rand(6))
#       i += 1
#     end
#   end
# end
#
# class MainClass
#   def test_rolling_the_dice_returns_a_set_of_integers_between_1_and_6
#     dice = DiceSet2.new
#
#     dice.roll(5)
#     assert dice.values.is_a?(Array), "should be an array"
#     assert_equal 5, dice.values.size
#     dice.values.each do |value|
#       assert value >= 1 && value <= 6, "value #{value} must be between 1 and 6"
#     end
#   end
# end

class DiceSet2
  attr_reader :values
  @values = []
  def roll(num)
    i = 0
    while i < num
      @values << 1
      i += 1
    end
    puts values
  end
end

class MainClass
  dice = DiceSet2.new
  dice.roll(5);
end


 class DiceSet
   attr_reader :values

   # Initializer
   def initialize
      @values = []
   end

   def roll(num)
     @values = []
     i = 0
     while i < num
       @values << (1 + rand(6))
       i += 1
     end
   end
 end

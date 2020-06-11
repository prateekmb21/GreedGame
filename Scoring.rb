class Scoring
  attr_reader :dice

  def initialize(dice=[])
    @dice = dice
  end

  def score(dice)
    hattrickNum = 0
    sum = 0
    sd = "scoringDigit"

    # For empty dice array
    if (dice.empty?)
      return 0
    end

    # Check which dice number has a hattrick
    if (dice.size >= 3)
      (1..6).each  do |num|
         hattrickNum = num if (dice.count(num) >= 3)
       end
    end

    # Evaluate hattrick scores
    if(dice.size >= 3)
      if(hattrickNum==1)
        sum += 1000
      else
        sum += (hattrickNum * 100)
      end
    end

    # Remove hattricked elements from dice array
    if(hattrickNum!=0)
      (1..3).each{ dice.delete_at(dice.index(hattrickNum)) }
    end

    # Do rest of the scoring and delete scoring dice
    dice.each { |num|
      if (num==1)
        sum += 100
        dice[dice.index(num)] = sd      # Mechanism to mark for deletion
      elsif (num==5)
        sum += 50
        dice[dice.index(num)] = sd      # Mechanism to mark for deletion
      end
    }

    # Delete marked elements now
    timesToDelete = dice.count(sd)
    timesToDelete.times {
        dice.delete_at(dice.index(sd))
    }

    @dice = dice
    return sum
  end
end

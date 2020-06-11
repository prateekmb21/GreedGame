  class Player
    attr_reader :totalScore, :name, :started

    def initialize(name,score=0,started=false)
      @name = name
      @totalScore = score
      @started = started
    end

    def setTotalScore(score)
      @totalScore = score
    end

    def setStarted(flag)
      @started = flag
    end
  end

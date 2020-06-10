  class Player
    attr_reader :totalScore, :playing, :name, :started, :diceset

    def initialize(name,score=0,playing=true,started=false,diceset=[])
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

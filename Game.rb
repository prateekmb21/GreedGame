require File.expand_path(File.dirname(__FILE__) + '/Diceset')
require File.expand_path(File.dirname(__FILE__) + '/Player')
require File.expand_path(File.dirname(__FILE__) + '/Scoring')

class Game
  # Everything comes together here
  def playGame
    breakTurn = 0
    turn = 1
    playerArray = []
    puts "Please enter number of players"
    numOfPlayers = (gets.chomp).to_f.round
    if (numOfPlayers < 2)
      puts "You just tried to trick the game by passing <2 players. But as mercy, I am setting a default as 2 players"
      numOfPlayers = 2
    end

    numOfPlayers.times { |i|
      pname = "Player" + (i+1).to_s
      p = Player.new(pname)
      playerArray << p
    }

    isFinalTurn = false
    while true                                    # This is the turn going into every player
      puts "Turn #{turn} has started"
      puts "------------------"
      playerArray.each { |player|                 # Here the turn iterates through each player
        totalTurnScore = 0
        turnIterator = 1
        diceCount = 5
        while true
          diceSet = DiceSet.new
          diceSet.roll(diceCount)

          scoreObject = Scoring.new
          puts "#{player.name} rolls: #{diceSet.values}"
          turn_score = scoreObject.score(diceSet.values)
          totalTurnScore += turn_score
          puts "Score in this round: #{turn_score}"
          puts "Score in this turn: #{totalTurnScore}"
          puts "Total score: #{player.totalScore}"

          # Break the turn if rolling results in zero
          if (turn_score==0)
            puts "#{player.name} has lost their turn due to zero score"
            totalTurnScore = 0
            break
          end

          # Ask the player for further input
          if (turnIterator==1 && diceSet.values.size==0)
            puts "All of your dice scored. Do you want to roll them again? (y/n)"
            response = gets.chomp
            if (response=="n")
              break if (response=="n")
            elsif (response=="y")
              diceCount = 5
              turnIterator += 1
              next
            else
              puts "Invalid response: You are guilty of misleading the game. Your turn points are equated to 0"
              totalTurnScore = 0
              break
            end
          elsif(diceSet.values.size>0)
            puts "Do you want to roll the non-scoring #{scoreObject.dice.size} dice? (y/n)"
            response_nonscoring = gets.chomp
            if (response_nonscoring=="n")
              break
            elsif (response_nonscoring=="y")
              diceCount = diceSet.values.size
              turnIterator += 1
              next
            else
              puts "Invalid response: You are guilty of misleading the game. Your turn points are equated to 0"
              totalTurnScore = 0
              break
            end
          elsif(diceSet.values.size==0)
            break
          end
        end

        # Getting in the game - condition
        if(!player.started)
          if (totalTurnScore >= 300)
            player.setStarted(true)
          end
        end

        # Accumulate points into total score only when getting in the game condition is satisfied
        if (player.started)
          player_score = player.totalScore
          player_score += totalTurnScore
          player.setTotalScore(player_score)
        end
        puts "Total score: #{player.totalScore}"
        puts "------------------"
        if(player.totalScore >= 3000)
          if(!isFinalTurn)
            breakTurn = turn + 1 # One final turn
            isFinalTurn = true
            puts "**** PLAYER WITH SCORE MORE THAN 3000 FOUND. NEXT TURN WILL BE THE FINAL TURN (TURN #{breakTurn}) ****"
          end
        end
      }
      puts "------------------"
      puts "Player scores after Turn #{turn}"
      puts "------------------"
      playerArray.each { |player|
        puts "#{player.name}: #{player.totalScore}"
      }
      puts "------------------"
      break if turn==breakTurn  # Break the game after the final turn
      turn += 1
    end

    # Sort the player array by total score to declare the winner
    playerArray.sort_by!(&:totalScore)
    return playerArray[-1].name
  end

  # The orchestrator
  game = Game.new
  winner = game.playGame
  puts "WINNER IS #{winner}. YOU HAVE TO TREAT EVERYONE!"
end

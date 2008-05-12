require 'player_random.rb'

module TicTacToe

  class RandomFinishPlayer < RandomPlayer

    def name
      "Random Finish"
    end

    def select_move(grid)
      # Play randomly, but connect three if possible

      for i in get_empty_fields(grid)
	grid.play(i)
	gamestate = grid.gamestate
	grid.undo

	if (gamestate != :ongoing) and (gamestate != :tie)
	  return i
	end
      end
      return super(grid)
    end

  end

end

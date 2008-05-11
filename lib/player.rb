
module TicTacToe

  class Player

    def name
      "Player"
    end

    def check_for_valid_grid(grid)
      if not grid.instance_of?(TicTacToe::Grid)
	raise IllegalArgumentError, "Not a grid"
      end

      if not grid.gamestate == :ongoing
	raise IllegalArgumentError, "Grid not playable"
      end
    end

    def make_move(grid)
      check_for_valid_grid(grid)

      for i in (0..8) do
	if grid.fields[i] == :empty
	  grid.play(i)
	  break
	end
      end
    end

  end

  class IllegalArgumentError < StandardError; end
end


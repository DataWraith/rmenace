
module TicTacToe

  class Player
    attr_reader :name

    def initialize
      @name = "Player"
    end

    def name=(new_name)
      @name = new_name unless new_name == ""
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


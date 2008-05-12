
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

    def get_empty_fields(grid)
      empty_fields = (0..8).to_a
      empty_fields.delete_if { |x| grid.fields[x] != :empty }
      return empty_fields
    end

    def make_move(grid)
      check_for_valid_grid(grid)
      grid.play(select_move(grid))
    end

    def select_move(grid)
      # Select the first free field starting from top-left
      for i in (0..8) do
	if grid.fields[i] == :empty
	  return i
	end
      end
    end

  end

  class IllegalArgumentError < StandardError; end
end



module TicTacToe

  class RandomPlayer < Player

    def name
      "Random"
    end

    def name=
      # No changing allowed
    end

    def make_move(grid)
      if not grid.instance_of?(TicTacToe::Grid)
	raise IllegalArgumentError, "Not a grid"
      end

      if not grid.gamestate == :ongoing
	raise IllegalArgumentError, "Grid not playable"
      end

      fields = (0..8).to_a
      fields.delete_if { |x| grid.fields[x] != :empty }
      fields.sort_by { rand }

      grid.play(fields[0])
    end

  end

end

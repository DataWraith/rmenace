require 'player.rb'

module TicTacToe

  class RandomPlayer < Player

    def name
      "Random"
    end

    def name=
      # No changing allowed
    end

    def make_move(grid)
      check_for_valid_grid(grid)

      fields = (0..8).to_a
      fields.delete_if { |x| grid.fields[x] != :empty }
      fields.sort_by { rand }

      grid.play(fields[0])
    end

  end

end

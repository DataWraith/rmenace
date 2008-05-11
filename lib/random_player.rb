require 'player.rb'

module TicTacToe

  class RandomPlayer < Player

    def name
      "Random"
    end

    def select_move(grid)
      fields = (0..8).to_a
      fields.delete_if { |x| grid.fields[x] != :empty }
      fields.sort_by { rand }

      return fields[0]
    end

  end

end

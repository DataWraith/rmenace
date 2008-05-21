
require File.dirname(__FILE__) + '/player.rb'

module TicTacToe

  class RandomPlayer < Player

    def name
      "Random"
    end

    def select_move(grid)
      # Select a random move
      fields = grid.legal_moves
      fields = fields.sort_by { rand }

      return fields.first
    end

  end

end

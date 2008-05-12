require 'player.rb'

module TicTacToe

  class RandomPlayer < Player

    def name
      "Random"
    end

    def select_move(grid)
      # Select a random move
      fields = get_empty_fields(grid)
      fields = fields.sort_by { rand }

      return fields.first
    end

  end

end


module TicTacToe

  class Player

    def name
      "Player"
    end

    def make_move(grid)
      check_for_valid_grid(grid)
      grid.play(select_move(grid))
    end

    private

    def check_for_valid_grid(grid)
      if not grid.instance_of?(TicTacToe::Grid)
        raise IllegalArgumentError, "Not a grid"
      end

      if not grid.gamestate == :ongoing
        raise IllegalArgumentError, "Grid not playable"
      end
    end

    def select_move(grid)
      # Select the first free field starting from top-left
      return grid.legal_moves.first
    end

  end

  class IllegalArgumentError < StandardError; end
end


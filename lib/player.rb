
module TicTacToe

  class Player

    def name
      "Player"
    end

    def make_move(grid)
      check_for_valid_grid(grid)
      check_for_playable_grid(grid)
      grid.play(select_move(grid))
    end

    def end_of_game(grid)
      # This method is called at the end of a game to allow learning players to
      # learn from the outcome of the game.

      check_for_valid_grid(grid)

      if grid.gamestate == :ongoing
        raise IllegalArgumentError, "Not a finished game"
      end
    end

    private

    def check_for_valid_grid(grid)
      if not grid.instance_of?(TicTacToe::Grid)
        raise IllegalArgumentError, "Not a grid"
      end
    end

    def check_for_playable_grid(grid)
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


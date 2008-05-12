require 'player.rb'

module TicTacToe

  class MinimaxPlayer < Player

    def name
      "MiniMax"
    end

    def select_move(grid)
      search_grid = grid.clone

      i_am_x = (grid.to_move == :x)

      best_move = -1
      best_value = -Infinity

      for i in get_empty_fields(grid) do
	search_grid.play(i)

	value = minimax(search_grid)
	value *= -1 unless i_am_x

	if (value > best_value) or ((value == best_value) and (rand >= 0.5))
	  best_move = i
	  best_value = value
	end

	search_grid.undo
      end

      grid.play(best_move)
    end

    def minimax(grid)

      case grid.gamestate
      when :tie
	return 0
      when :x_wins
	return Infinity
      when :o_wins
	return -Infinity
      end

      alpha = -Infinity
      for i in get_empty_fields(grid) do
	grid.play(i)
	alpha = max(alpha, -minimax(grid))
	grid.undo
      end

      return alpha
    end


  end

end

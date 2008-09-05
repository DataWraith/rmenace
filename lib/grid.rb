

module TicTacToe

  # Grid provides a simple Tic Tac Toe grid.
  #
  # It keeps track of the Gamestate and allows you to make and undo moves.
  class Grid

    # An array with the current content of the grid fields (:x, :o or :empty)
    attr_reader :fields

    # The number of moves made so far
    attr_reader :move_nr

    # The player to move (:x, :o, :no_one)
    attr_reader :to_move

    # An array containing the previously made moves (their field-indices)
    attr_reader :history

    # The current gamestate (:onging, :x_wins, :o_wins, :tie)
    attr_reader :gamestate

    # Create a new Grid
    def initialize
      @move_nr      = 0
      @to_move      = :x
      @history      = []
      @gamestate    = :ongoing
      @fields       = [:empty]*9
      @empty_fields = (0..8).to_a
    end

    # Make a move by passing in an index into the grid, with 0 being top-left
    # and 8 being bottom-right.
    #
    # The method may raise an IllegalMoveError if you specify an ivalid index,
    # specify a field that already is occupied or want to play into a grid when
    # the game has already ended.
    def play(which_field)

      if not (0..8).include?(which_field)
        raise IllegalMoveError, "Invalid field"
      end

      if @fields[which_field] != :empty
        raise IllegalMoveError, "Field occupied"
      end

      if @gamestate != :ongoing
        raise IllegalMoveError, "Game already ended"
      end

      @history.push(which_field)
      @fields[which_field] = @to_move
      @empty_fields.delete(which_field)

      @move_nr += 1

      change_player_to_move
      adjust_gamestate

      return @gamestate
    end

    # Undo the last move.
    #
    # Raises an UndoImpossibleError if no moves have been made yet.
    def undo

      if @move_nr == 0
        raise UndoImpossibleError, "No moves played yet"
      end

      to_undo = @history.pop
      @fields[to_undo] = :empty

      @empty_fields += [to_undo]

      @gamestate = :ongoing
      @move_nr -= 1

      change_player_to_move
    end

    # Return an array that contains all moves that are currently legal
    def legal_moves
      if @gamestate != :ongoing
        return []
      else
        return @empty_fields
      end
    end

    private

    FIELDS_TO_CHECK = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], # rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], # columns
      [0, 4, 8], [2, 4, 6]             # diagonals
    ]

    def change_player_to_move
      if (@move_nr % 2) == 0
        @to_move = :x
      else
        @to_move = :o
      end
    end

    def adjust_gamestate
      winner = :neither

      FIELDS_TO_CHECK.each do |f|
        if (@fields[f[0]] == @fields[f[1]]) and (@fields[f[1]] == @fields[f[2]])
          winner = @fields[f[0]]
          break
        end
      end

      case winner
      when :x
        @gamestate = :x_wins
      when :o
        @gamestate = :o_wins
      else
        if (@move_nr == 9)
          @gamestate = :tie
        else
          @gamestate = :ongoing
        end
      end

      if @gamestate != :ongoing
        @to_move = :no_one
      end
    end

  end

  class IllegalMoveError < StandardError; end
  class UndoImpossibleError < StandardError; end
end

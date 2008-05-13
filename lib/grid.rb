

module TicTacToe

  class Grid
    attr_reader :fields
    attr_reader :move_nr
    attr_reader :to_move
    attr_reader :history
    attr_reader :gamestate

    def initialize
      @move_nr   = 0
      @to_move   = :x
      @history   = []
      @gamestate = :ongoing
      @fields    = [:empty]*9
    end

    def play(which_field)

      if @gamestate != :ongoing
        raise IllegalMoveError, "Game already ended"
      end

      if not (0..8).include?(which_field)
        raise IllegalMoveError, "Invalid field"
      end

      if @fields[which_field] != :empty
        raise IllegalMoveError, "Field occupied"
      end

      @fields[which_field] = @to_move
      @history.push(which_field)
      @move_nr += 1

      change_player_to_move
      adjust_gamestate(which_field)
    end

    def undo
      if @move_nr == 0
        raise UndoImpossibleError, "No moves played yet"
      end

      @fields[@history.pop] = :empty
      @gamestate = :ongoing
      @move_nr -= 1

      change_player_to_move
    end

    private

    @@FIELDS_TO_CHECK = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], # rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], # columns
      [0, 4, 8], [2, 4, 6]             # diagonals
    ]

    def change_player_to_move
      if @to_move == :x
        @to_move = :o
      else
        @to_move = :x
      end
    end

    def adjust_gamestate(changed_field)
      winner = :neither

      @@FIELDS_TO_CHECK.each do |f|
        if f.include?(changed_field)
          if (@fields[f[0]] == @fields[f[1]]) and (@fields[f[1]] == @fields[f[2]])
            winner = @fields[changed_field]
          end
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
    end

  end

  class IllegalMoveError < StandardError; end
  class UndoImpossibleError < StandardError; end
end

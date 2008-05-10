

module MENACE
  
  class Grid
    attr_reader :fields
    attr_reader :move_nr
    attr_reader :to_move
    attr_reader :history
    attr_reader :gamestate
    
    def initialize
      @fields = [:empty]*9
      @move_nr = 0
      @to_move = :x
      @history = []
      @gamestate = :ongoing
    end
    
    def play(which_field)
      if not (0..8).include?(which_field) 
	raise IllegalMoveError, "Invalid field"
      end
	
      if @fields[which_field] != :empty
	raise IllegalMoveError, "Field occupied"
      end
	
      @fields[which_field] = @to_move
      @history.push(which_field)
      @move_nr += 1
      
      if @move_nr == 9
	@gamestate = :tie
      end
      
      change_player_to_move
    end
    
    def undo
      if @move_nr > 0
	@fields[@history.pop] = :empty
	change_player_to_move
      else
	raise UndoImpossibleError, "No moves played yet"
      end
    end
    
    private
    
    def change_player_to_move
      if @to_move == :x
	@to_move = :o
      else
	@to_move = :x
      end
    end
    
  end
  
  class IllegalMoveError < StandardError; end
  class UndoImpossibleError < StandardError; end
end

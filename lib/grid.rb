

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
      adjust_gamestate(which_field)
    end
    
    def undo
      if @move_nr > 0
	field_to_change = @history.pop
	@fields[field_to_change] = :empty
	change_player_to_move
	@move_nr -= 1
	adjust_gamestate(field_to_change)
      else
	raise UndoImpossibleError, "No moves played yet"
      end
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
      if @fields[changed_field] == :empty
	# Called from undo(), so we just set gamestate to :ongoing
	@gamestate = :ongoing
      else
	# Called from play(), so we need to see whether someone won 
	result = :ongoing
	@@FIELDS_TO_CHECK.each do |field|
	  if field.include?(changed_field)
	    if (@fields[field[0]] == @fields[field[1]]) and 
		(@fields[field[0]] == @fields[field[2]])
	      result = @fields[changed_field]
	    end
	  end
        end
	case result
	when :ongoing
	  if (@move_nr == 9)
	    @gamestate = :tie
	  else
	    @gamestate = :ongoing
	  end
	when :x
	  @gamestate = :x_wins
	when :o
	  @gamestate = :o_wins
	end
      end
    end
  
  end
   
  
  class IllegalMoveError < StandardError; end
  class UndoImpossibleError < StandardError; end
end

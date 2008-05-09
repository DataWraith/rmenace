

module MENACE
  
  class Grid
    attr_reader :fields
    attr_reader :move_nr
    attr_reader :to_move
    attr_reader :history
    
    def initialize
      @fields = [:empty]*9
      @move_nr = 0
      @to_move = :x
      @history = []
    end
    
    def play(which_field)
      if (0..8).include?(which_field) 
	
	if @fields[which_field] != :empty
	  raise IllegalMoveError, "Field occupied"
	end
	
	@fields[which_field] = :to_move  
	@history.push(which_field)
	
      else
	raise IllegalMoveError, "Invalid field"
      end
      
      if @to_move == :x
	@to_move = :o
      else
	@to_move = :x
      end
    end
    
  end
  
  class IllegalMoveError < StandardError; end

end


module TicTacToe

  class Player
    attr_reader :name

    def initialize
      @name = "Player"
    end

    def name=(new_name)
      @name = new_name unless new_name == ""
    end
  end

end


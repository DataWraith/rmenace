 
require 'grid'

describe "An empty TicTacToe grid" do
  
  before(:each) do
    @grid = MENACE::Grid.new
  end
  
  it "should be empty" do
    @grid.fields.should == [:empty]*9
  end
  
  it "should have move number zero" do
    @grid.move_nr.should == 0
  end
   
  it "should have an empty move history" do
    @grid.history.should == []
  end
  
  it "should not allow undo" do
    lambda {@grid.undo}.should raise_error(MENACE::UndoImpossibleError, "No moves played yet")
  end
   
  it "should have :x to move" do
    @grid.to_move.should == :x
  end
   
  (0..8).each do |field|
    it "should allow playing into field #{field}" do
      @grid.play(field).should_not raise_error(MENACE::IllegalMoveError, "IllegalMove")
    end
    
    it "should record a valid move into field #{field}" do
      @grid.play(field)
      @grid.fields.should == [:empty]*field + [:x] + [:empty]*(8-field)
    end
  end
end
  

describe "A TicTacToe grid" do
  
  before(:each) do
    @grid = MENACE::Grid.new
  end

  it "should exist" do
    @grid.should_not == nil
    @grid.should be_an_instance_of(MENACE::Grid)
  end
  
  it "should not allow playing outside the field" do
    lambda {@grid.play(-1)}.should raise_error(MENACE::IllegalMoveError, "Invalid field")
    lambda {@grid.play(9)}.should raise_error(MENACE::IllegalMoveError, "Invalid field")
  end

  it "should change the player to move after a valid move" do
    @grid.play(0)
    @grid.to_move.should == :o
      
    @grid.play(1)
    @grid.to_move.should == :x
  end
  
  it "should increase the move number after a valid move" do
    @grid.play(0)
    @grid.move_nr.should == 1
  end
  
  it "should not allow playing into an occupied field" do
    @grid.play(0)
    lambda {@grid.play(0)}.should raise_error(MENACE::IllegalMoveError, "Field occupied")
  end
   
  it "should record history" do
    @grid.play(0)
    @grid.history.should == [0]
     
    @grid.play(1)
    @grid.history.should == [0, 1]
  end
  
end

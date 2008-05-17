
require File.dirname(__FILE__) + '/../lib/grid.rb'

describe "An empty TicTacToe grid" do

  before(:each) do
    @grid = TicTacToe::Grid.new
  end

  it "should exist" do
    @grid.should_not == nil
    @grid.should be_an_instance_of(TicTacToe::Grid)
  end

  it "should be empty" do
    @grid.fields.should == [:empty]*9
  end

  it "should have move-number zero" do
    @grid.move_nr.should == 0
  end

  it "should have an empty move-history" do
    @grid.history.should == []
  end

  it "should have gamestate == :ongoing" do
    @grid.gamestate.should == :ongoing
  end

  it "should not allow undo" do
    lambda {@grid.undo}.should raise_error(TicTacToe::UndoImpossibleError, "No moves played yet")
  end

  it "should have :x as the player to move" do
    @grid.to_move.should == :x
  end

  (0..8).each do |field|
    it "should allow playing into field #{field}" do
      @grid.play(field).should_not raise_error(TicTacToe::IllegalMoveError, "Illegal field")
    end

    it "should record a valid move into field #{field}" do
      @grid.play(field)
      @grid.fields.should == [:empty]*field + [:x] + [:empty]*(8-field)
    end

    it "should record a valid move on field #{field} into the history" do
      @grid.play(field)
      @grid.history.should == [field]
    end

  end

end


describe "A TicTacToe grid" do

  before(:each) do
    @grid = TicTacToe::Grid.new
    @grid.play(0)
    @grid.play(8)
  end

  it "should not allow playing outside the field" do
    lambda {@grid.play(-1)}.should raise_error(TicTacToe::IllegalMoveError, "Invalid field")
    lambda {@grid.play(9)}.should raise_error(TicTacToe::IllegalMoveError, "Invalid field")
  end

  it "should change the player to move after a valid move" do
    @grid.to_move.should == :x
    @grid.play(1)
    @grid.to_move.should == :o
  end

  it "should change the player to move after a valid undo" do
    @grid.to_move.should == :x
    @grid.undo
    @grid.to_move.should == :o
    @grid.undo
    @grid.to_move.should == :x
    lambda {@grid.undo}
    @grid.to_move.should == :x
  end

  it "should increment the move-number after a valid move" do
    @grid.move_nr.should == 2
    @grid.play(5)
    @grid.move_nr.should == 3
  end

  it "should decrement the move-number after a valid undo" do
    @grid.move_nr.should == 2
    @grid.undo
    @grid.move_nr.should == 1
    @grid.undo
    @grid.move_nr.should == 0
    lambda {@grid.undo}
    @grid.move_nr.should == 0
  end

  it "should not allow playing into an occupied field" do
    lambda {@grid.play(0)}.should raise_error(TicTacToe::IllegalMoveError, "Field occupied")
  end

  it "should record history" do
    @grid.history.should == [0, 8]

    @grid.play(1)
    @grid.history.should == [0, 8, 1]
  end

end

describe "A TicTacToe Grid with a finished game", :shared => true do

  before(:each) do
    @grid = TicTacToe::Grid.new
    [0, 8, 1, 7, 2].each do |f|
      @grid.play(f)
    end
  end

  it "should not allow playing on empty fields" do
    for i in (0..8)
      if @grid.fields[i] == :empty
        lambda {@grid.play(i)}.should raise_error(TicTacToe::IllegalMoveError, "Game already ended")
      end
    end
  end

  it "should have :no_one to_move" do
    @grid.to_move.should == :no_one
  end

  it "should allow undo" do
    lambda {@grid.undo}.should_not raise_error
  end

  it "should have the correct player @to_move after undo" do
    @grid.undo

    if (@grid.move_nr % 2) == 0
      @grid.to_move.should == :x
    else
      @grid.to_move.should == :o
    end
  end

end

describe "A TicTacToe Grid with a tied game" do

  it_should_behave_like "A TicTacToe Grid with a finished game"

  before(:each) do
    @grid = TicTacToe::Grid.new
    [0, 8, 1, 2, 5, 4, 6, 3, 7].each do |f|
      @grid.play(f)
    end
  end

  it "should have gamestate :tie" do
    @grid.gamestate.should == :tie
  end

end

describe "A TicTacToe Grid with a game won by X" do

  it_should_behave_like "A TicTacToe Grid with a finished game"

  before(:each) do
    @grid = TicTacToe::Grid.new
    [0, 8, 1, 7, 2].each do |f|
      @grid.play(f)
    end
  end

  it "should have gamestate :x_wins" do
    @grid.gamestate.should == :x_wins
  end

end

describe "A TicTacToe Grid with a game won by O" do

  it_should_behave_like "A TicTacToe Grid with a finished game"

  before(:each) do
    @grid = TicTacToe::Grid.new
    [0, 8, 1, 2, 3, 5].each do |f|
      @grid.play(f)
    end
  end

  it "should have gamestate :o_wins" do
    @grid.gamestate.should == :o_wins
  end

end

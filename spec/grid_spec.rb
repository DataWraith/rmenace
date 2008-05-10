
require File.dirname(__FILE__) + '/../lib/grid.rb'

describe "An empty TicTacToe grid" do

  before(:each) do
    @grid = MENACE::Grid.new
  end

  it "should exist" do
    @grid.should_not == nil
    @grid.should be_an_instance_of(MENACE::Grid)
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
    lambda {@grid.undo}.should raise_error(MENACE::UndoImpossibleError, "No moves played yet")
  end

  it "should have :x as the player to move" do
    @grid.to_move.should == :x
  end

  (0..8).each do |field|
    it "should allow playing into field #{field}" do
      @grid.play(field).should_not raise_error(MENACE::IllegalMoveError, "Illegal field")
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
    @grid = MENACE::Grid.new
    @grid.play(0)
    @grid.play(8)
  end

  it "should not allow playing outside the field" do
    lambda {@grid.play(-1)}.should raise_error(MENACE::IllegalMoveError, "Invalid field")
    lambda {@grid.play(9)}.should raise_error(MENACE::IllegalMoveError, "Invalid field")
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

  it "should reduce the move-number after a valid undo" do
    @grid.move_nr.should == 2
    @grid.undo
    @grid.move_nr.should == 1
    @grid.undo
    @grid.move_nr.should == 0
    lambda {@grid.undo}
    @grid.move_nr.should == 0
  end

  it "should increase the move-number after a valid move" do
    @grid.move_nr.should == 2
  end

  it "should not allow playing into an occupied field" do
    lambda {@grid.play(0)}.should raise_error(MENACE::IllegalMoveError, "Field occupied")
  end

  it "should record history" do
    @grid.history.should == [0, 8]

    @grid.play(1)
    @grid.history.should == [0, 8, 1]
  end

end

describe "A TicTacToe Grid with a finished game" do

  before(:each) do
    @grid = MENACE::Grid.new
    @grid.play(0)
    @grid.play(8)
    @grid.play(1)
  end

  it "should not allow playing on empty fields" do
    @grid.play(7)
    @grid.play(2)
    for i in (0..8)
      if @grid.fields[i] == :empty
	lambda {@grid.play(i)}.should raise_error(MENACE::IllegalMoveError, "Game already ended")
      end
    end
  end

  it "should have gamestate :tie after a tie" do
    @grid.play(2)
    @grid.play(5)
    @grid.play(4)
    @grid.play(6)
    @grid.play(3)
    @grid.play(7)
    @grid.gamestate.should == :tie
  end

  it "should have gamestate :x_wins after X wins" do
    @grid.play(7)
    @grid.play(2)
    @grid.gamestate.should == :x_wins
  end

  it "should have gamestate :o_wins after O wins" do
    @grid.play(2)
    @grid.play(3)
    @grid.play(5)
    @grid.gamestate.should == :o_wins
  end

end

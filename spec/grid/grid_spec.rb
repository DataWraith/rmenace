
require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

require 'grid.rb'

describe "A TicTacToe grid", :shared => true do

  before(:each) do
    @grid = TicTacToe::Grid.new
    @grid.play(0)
    @grid.play(8)
  end

  # Grid

  it "should exist" do
    @grid.should_not be_nil
    @grid.should be_an_instance_of(TicTacToe::Grid)
  end

  # Grid.play

  it "should complain about invalid moves" do
    lambda {@grid.play(-1)}.should raise_error(TicTacToe::IllegalMoveError, "Invalid field")
    lambda {@grid.play(9)}.should raise_error(TicTacToe::IllegalMoveError, "Invalid field")
    lambda {@grid.play(nil)}.should raise_error(TicTacToe::IllegalMoveError, "Invalid field")
    lambda {@grid.play("foo")}.should raise_error(TicTacToe::IllegalMoveError, "Invalid field")
  end

  it "should not complain about valid moves" do
    for i in @grid.legal_moves
      lambda{@grid.play(i)}.should_not raise_error
      @grid.undo
    end
  end

  it "should not allow playing into an occupied field" do
    for i in (0..8)
      if @grid.fields[i] != :empty
        lambda {@grid.play(i)}.should raise_error(TicTacToe::IllegalMoveError, "Field occupied")
      end
    end
  end

  it "should record all legal moves correctly" do
    for i in @grid.legal_moves
      @grid.play(i)
      @grid.fields[i].should_not == :empty
      @grid.history.last.should == i
      @grid.undo
    end
  end

  # Grid.to_move

  it "should change the player to move after a valid move" do
    to_move = @grid.to_move
    if @grid.gamestate == :ongoing
      @grid.play(@grid.legal_moves.first)
      @grid.to_move.should_not == to_move
    end
  end

  it "should change the player to move after a valid undo" do
    if @grid.move_nr != 0
      to_move = @grid.to_move
      @grid.undo
      @grid.to_move.should_not == to_move
    end
  end

  # Grid.move_nr

  it "should increment the move-number after a valid move" do
    if @grid.gamestate == :ongoing
      move_nr = @grid.move_nr
      @grid.play(@grid.legal_moves.first)
      @grid.move_nr.should == move_nr + 1
    end
  end

  it "should decrement the move-number after a valid undo" do
    if @grid.move_nr != 0
      move_nr = @grid.move_nr
      @grid.undo
      @grid.move_nr.should == move_nr - 1
    else
      lambda{@grid.undo}
      @grid.move_nr.should == 0
    end
  end

  # Grid.history

  it "should have recorded every move in the history-array" do
    for i in (0..8)
      if @grid.fields[i] != :empty
        @grid.history.should include(i)
      end
    end
  end

  it "should have the history agree with move_nr on the number of moves played so far" do
    @grid.move_nr.should == @grid.history.length
  end

  # Grid.legal_moves

  it "should return all legal moves" do
    legal_moves = @grid.legal_moves

    if @grid.gamestate != :ongoing
      legal_moves.should be_empty
    else
      for i in (0..8)
        if @grid.fields[i] == :empty
          legal_moves.should include(i)
        end
      end
    end
  end

end

describe "An empty TicTacToe grid" do

  it_should_behave_like "A TicTacToe grid"

  before(:each) do
    @grid = TicTacToe::Grid.new
  end

  it "should be empty" do
    @grid.fields.should == [:empty]*9
  end

  it "should have move-number zero" do
    @grid.move_nr.should == 0
  end

  it "should have an empty move-history" do
    @grid.history.should be_empty
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

end

describe "A TicTacToe Grid with a finished game", :shared => true do

  it_should_behave_like "A TicTacToe grid"

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

  it "should have all fields occupied" do
    @grid.fields.should_not include(:empty)
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


require File.dirname(__FILE__) + '/../lib/player.rb'
require File.dirname(__FILE__) + '/../lib/grid.rb'

describe "A Player", :shared => true do

  before(:each) do
    @player = TicTacToe::Player.new
  end

  it "should exist" do
    @player.should_not be_nil
  end

  it "should have a name" do
    @player.name.should be_an_instance_of(String)
    @player.name.should_not == ""
  end

  it "should make exactly one move when prompted to" do
    grid = TicTacToe::Grid.new
    grid.play(4)
    grid.play(1)
    history_before = grid.history
    @player.make_move(grid)
    history_after = grid.history

    history_after.pop
    history_after.should == history_before
  end

  it "should raise an error, when given an invalid grid object" do
    lambda {@player.make_move(nil)}.should raise_error(TicTacToe::IllegalArgumentError, "Not a grid")
    lambda {@player.make_move(0)}.should raise_error(TicTacToe::IllegalArgumentError, "Not a grid")

    grid = TicTacToe::Grid.new
    [0, 1, 4, 5, 8].each do |f|
      grid.play(f)
    end

    lambda {@player.make_move(grid)}.should raise_error(TicTacToe::IllegalArgumentError, "Grid not playable")
  end
end

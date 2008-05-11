
require File.dirname(__FILE__) + '/../lib/player.rb'
require File.dirname(__FILE__) + '/../lib/grid.rb'

describe "A Player" do

  before(:each) do
    @Player = TicTacToe::Player.new
  end

  it "should exist" do
    @Player.should_not be_nil
    @Player.should be_an_instance_of(TicTacToe::Player)
  end

  it "should be named \"Player\"" do
    @Player.name.should == "Player"
  end

  it "should make exactly one move when prompted to" do
    grid = TicTacToe::Grid.new
    grid.play(4)
    grid.play(1)
    history_before = grid.history
    @Player.make_move(grid)
    history_after = grid.history

    history_after.pop
    history_after.should == history_before
  end

  it "should raise an error, when given an invalid grid object" do
    lambda {@Player.make_move(nil)}.should raise_error(TicTacToe::IllegalArgumentError, "Not a grid")
    lambda {@Player.make_move(0)}.should raise_error(TicTacToe::IllegalArgumentError, "Not a grid")

    grid = TicTacToe::Grid.new
    [0, 1, 4, 5, 8].each do |f|
      grid.play(f)
    end

    lambda {@Player.make_move(grid)}.should raise_error(TicTacToe::IllegalArgumentError, "Grid not playable")
  end
end


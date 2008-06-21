
require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

require 'player.rb'
require 'grid.rb'

describe "A Player", :shared => true do

  before(:each) do
    @player = TicTacToe::Player.new
  end

  it "should exist" do
    @player.should_not be_nil
  end

  it "should have a name" do
    @player.name.should be_an_instance_of(String)
    @player.name.should_not be_empty
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

  it "should have a end_of_game method" do
    @player.should respond_to('end_of_game')
  end

  it "should have a end_of_game method that takes only finished games as argument" do
    grid = TicTacToe::Grid.new

    lambda {@player.end_of_game(nil, :x)}.should raise_error(TicTacToe::IllegalArgumentError, "Not a grid")
    lambda {@player.end_of_game(grid, :o)}.should raise_error(TicTacToe::IllegalArgumentError, "Not a finished game")

    [0, 1, 3, 4, 6].each do |f|
      grid.play(f)
    end

    lambda {@player.end_of_game(grid, nil)}.should raise_error(TicTacToe::IllegalArgumentError, "Invalid Player given")

    lambda {@player.end_of_game(grid, :x)}.should_not raise_error
    lambda {@player.end_of_game(grid, :o)}.should_not raise_error
  end

end

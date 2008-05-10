
require File.dirname(__FILE__) + '/../lib/player.rb'

describe "A Player" do

  before(:each) do
    @Player = TicTacToe::Player.new
  end

  it "should exist" do
    @Player.should_not be_nil
    @Player.should be_an_instance_of(TicTacToe::Player)
  end

  it "should initially be caled \"Player\"" do
    @Player.name.should == "Player"
  end

  it "shoud allow the name to be changed" do
    @Player.name = "John"
    @Player.name.should == "John"
  end

  it "should not allow the name to be changed to the empty string" do
    @Player.name = ""
    @Player.name.should_not == ""
  end
end


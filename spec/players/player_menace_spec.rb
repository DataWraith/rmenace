
require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

require 'player_menace.rb'
require 'player_spec.rb'

describe "A Player using the MENACE-algorithm" do

  it_should_behave_like "A Player"

  before(:each) do
    @player = TicTacToe::MENACE.new
  end

  it "should be named 'MENACE'" do
    @player.name.should == "MENACE"
  end

end

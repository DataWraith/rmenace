
$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'grid.rb'
require 'player.rb'
require 'player_random.rb'
require 'player_random_finish.rb'
require 'player_center_random.rb'
require 'player_minimax.rb'
require 'player_simple_learner.rb'

module TicTacToe

  class Tournament

    def initialize
      @players = []
      @players.push(SimpleLearner.new)
      @players.push(Player.new)
      @players.push(RandomPlayer.new)
      @players.push(RandomFinishPlayer.new)
      @players.push(CenterRandomPlayer.new)
      @players.push(MinimaxPlayer.new)
      @results = Hash.new(0)
    end

    def play_game(player1, player2)
      grid = Grid.new
      while grid.gamestate == :ongoing
        @players[player1].make_move(grid)
        @players[player2].make_move(grid) unless grid.gamestate != :ongoing
      end

      @players[player1].end_of_game(grid)
      @players[player2].end_of_game(grid)

      case grid.gamestate
      when :tie
        @results[@players[player1].name] += 1
        @results[@players[player2].name] += 1
        puts("Tie")
      when :x_wins
        @results[@players[player1].name] += 3
        puts(@players[player1].name + " wins")
      when :o_wins
        @results[@players[player2].name] += 3
        puts(@players[player2].name + " wins")
      end
    end

    def run
      game_nr = 0
      for p1 in (0...@players.length)
        for p2 in (p1...@players.length)
          if p1 != p2
            15.times do
              game_nr += 1
              print("Game #{game_nr}: #{@players[p1].name} vs. #{@players[p2].name}: ")
              play_game(p1, p2)
              game_nr += 1
              print("Game #{game_nr}: #{@players[p2].name} vs. #{@players[p1].name}: ")
              play_game(p2, p1)
            end
          end
        end
      end
      p @results
    end
  end
end

t = TicTacToe::Tournament.new
t.run

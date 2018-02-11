require_relative "casino_title.rb"
require_relative "main_menu.rb"
require_relative "slots.rb"
require_relative "wallet.rb"
require_relative "bet.rb"
require_relative "game.rb"
require_relative "spin.rb"
require_relative "gameover.rb"
require 'io/console'

def start_the_game
  case main_menu
  when "1"
    slots 
  end
end

system "clear"

height, width = IO.console.winsize
# Reposition and resize the terminal
print "\e[3;0;0t"
print "\e[8;16;69t"

CasinoTitle.title_animate(0.06)
CasinoTitle.user_prompt
print "\e[8;50;100t"

@your_game = Game.new
@your_wallet = Wallet.new 0
@initial_amount = 0
@your_bet = Bet.new
@current_spin = Spin.new

start_the_game
game_over

# Change the terminal back to the previous size when the game is over
print "\e[8;#{height};#{width}t"
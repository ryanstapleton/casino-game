require_relative 'lever_pull.rb'
require_relative 'slots_helper.rb'
require_relative 'validations.rb'

def slots

  system 'clear' unless @your_game.play_again?
  spin unless @your_game.play_again?
  print "\x1B[1A\x1B[2K" if @your_game.play_again?
  
  # Refresh and display user choices
  @your_bet.amount = "0" 
  @your_bet.selections = []
  print "\x1B[2K"
  print "\x1B[2A"
  print "\x1B[2K"
  append_user_choices 


  # Bet validation
  loop do
    print "Choose a bet amount: $"
    bet = gets.chomp
    if bet.numeric? && (bet.to_i <= @your_wallet.balance)
      @your_bet.amount = bet
      print "\x1B[2K" # clear the current line
      print "\x1B[3A" # move up three lines
      print "\x1B[2K" # clear the line
      append_user_choices 
      print "\x1B[1B" # return cursor
      break
    elsif bet.numeric? && (bet.to_i > @your_wallet.balance)
      puts "I'm sorry, but you don't have that much ..."
      sleep(1)
      print "\x1B[1A\x1B[2K" # move up and clear
      print "\x1B[1A\x1B[2K" 
    else
      puts "That's not a valid amount ..."
      sleep(0.6)
      print "\x1B[1A\x1B[2K" # move up and clear
      print "\x1B[1A\x1B[2K" 
    end
  end

  valid_options = %w(1 2 3 4 5)

  # Row selection validation
  loop do
    print "Make your row or diagonal selections: "
    selections = gets.chomp.scan(/\w/)
    if selections_validated?(selections, valid_options)
      @your_bet.selections = selections.sort
      print "\x1B[2K"
      print "\x1B[4A"
      print "\x1B[2K"
      append_user_choices
      print "\x1B[2B"
      break
    else
      sleep(0.6)
      print "\x1B[1A\x1B[2K" # move up and clear
      print "\x1B[1A\x1B[2K"
    end
  end

  print "\nPress Enter to pull the lever!"
  pull_the_lever if pressed_enter?

  evaluate_spin

  valid_options = %w(y yes n no)

  # Play agan validation
  loop do
    print "Spin again? (y/n) "
    response = gets.chomp.downcase

    if validated?(response, valid_options)
      if response == 'y' || response == 'yes'
        @your_game.play_again = true
        break
      else
        print "Cashing you out "
        sleep 0.5
        print "."
        sleep 0.5
        print "."
        sleep 0.5
        print "."
        sleep 0.5
        print "."
        sleep 0.5
        print "."
        sleep 0.5
        print "."
        sleep 0.5
        @your_wallet.profit = @your_wallet.balance - @initial_amount
        if @your_wallet.profit > 0
          puts "\nCongratulations! You profited $#{@your_wallet.profit}!"
          sleep 4
        elsif @your_wallet.profit < 0
          puts "\nYou took a loss of $#{@your_wallet.profit.abs}."
          if @your_wallet.balance.negative?
            puts "You owe $#{@your_wallet.balance}. How would you like to pay for that?  ^_^"
            sleep 1
          end
          sleep 4
        else
          puts "\nYou came out even today. Come back again!"
          sleep 3
        end
        @your_game.play_again = false
        break
      end
    else 
      sleep(0.6)
      print "\x1B[1A\x1B[2K" # move up one and clear
      print "\x1B[1A\x1B[2K"
    end
  end

  if @your_game.play_again?
    if @your_wallet.balance > 0
      slots
    elsif @your_wallet.balance <= 0
      puts "You're broke ... sorry!"
      sleep 1
      start_the_game
    end
  end
end

require_relative "validations.rb"

def main_menu
  selection = ""
  @your_game.play_again = false
  system "clear"

  puts "Welcome to the Casino!\nWhat would you like to play today?\n\n\n  1. Slots"
  valid_options = ['1']

  # Game selection validation
  loop do
    selection = gets.chomp.downcase

    if validated?(selection, valid_options)
      print "\n"
      break
    else 
      sleep(0.6)
      print "\x1B[1A\x1B[2K" # move up one and clear
      print "\x1B[1A\x1B[2K"
    end
  end

  # Wallet validation
  loop do
    print "You have $#{@your_wallet.balance} in your casino wallet. "
    if @your_wallet.balance <= 0
      print "How much would you like to deposit? "
    elsif @your_wallet.balance > 0
      done = false
      while done == false
        print "Would you like to make a deposit? (y/n) "
        response = gets.chomp.downcase
    
        if validated?(response, valid_options)
          if response == 'n' || response == 'no'
            done = true
            break
          else
            done = true
          end
        else 
          sleep(0.6)
          print "\x1B[1A\x1B[2K" # move up one and clear
          print "\x1B[1A\x1B[2K"
        end
      end
    end

    deposit = gets.chomp
    if deposit.numeric? && (@your_wallet.balance >= 0) && (deposit.to_i > 0) 
      @your_wallet.add_money(deposit.to_i)
      @initial_amount = deposit.to_i
      break
    elsif deposit.numeric? && (@your_wallet.balance < 0) && (deposit.to_i > @your_wallet.balance.to_i.abs)
      @your_wallet.add_money(deposit.to_i)
      @initial_amount = deposit.to_i
      break
    elsif deposit.numeric? && (@your_wallet.balance < 0) && (deposit.to_i <= @your_wallet.balance.to_i.abs)
      puts "You have to put something more in your wallet, you have a negative balance ..."
      sleep(3)
      print "\x1B[1A\x1B[2K" # move up and clear
      print "\x1B[1A\x1B[2K" 
    else 
      puts "That's not a valid amount ..."
      sleep(0.7)
      print "\x1B[1A\x1B[2K" # move up and clear
      print "\x1B[1A\x1B[2K" 
    end
  end
  
  selection
end
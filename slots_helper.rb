def append_user_choices
  puts "  Bet: $#{@your_bet.amount}\t\tWallet: $#{@your_wallet.balance}\t\tSelection(s): #{@your_bet.print_selections}\n\n"
end

def evaluate_spin
  @your_bet.selections.each do |selection|  
    case selection  
    when "1"
      # 246 - top diagonal
      diagonal = @current_spin.results.values_at(2,4,6)
      row_logic(diagonal, selection)
    when "2"
      # 012 - top row
      row = @current_spin.results.values_at(0,1,2)
      row_logic(row, selection)
    when "3"
      # 345 - middle row
      row = @current_spin.results.values_at(3,4,5)
      row_logic(row, selection)
    when "4"
      # 678 - bottom row
      row = @current_spin.results.values_at(6,7,8)
      row_logic(row, selection)
    when "5"
      # 048 - bottom diagonal
      diagonal = @current_spin.results.values_at(0,4,8)
      row_logic(diagonal, selection)
    end
  end

  # Display updates to wallet
  print "\x1B[2K"
  print "\x1B[2A"
  print "\x1B[2K"
  append_user_choices 
end

def row_logic line, selection
  if line.uniq.length == 1 # 3 duplicates?
    puts "A match on #{selection}! "
    matched_symbol = line.pop
    calculate_winnings(matched_symbol)
    sleep 1.5
    print "\x1B[1A\x1B[2K" # move up one and clear
  elsif line.uniq.length == 3 # All 3 unique?
    puts "A wash on #{selection} "
    sleep 1.5
    print "\x1B[1A\x1B[2K" # move up one and clear
  else
    puts "A loss on #{selection} "
    sleep 1.5
    print "\x1B[1A\x1B[2K" # move up one and clear
    @your_wallet.subtract_money(@your_bet.amount.to_i)
  end
end

def calculate_winnings symbol
  case symbol
  when 1
    @your_wallet.add_money(@your_bet.amount.to_i * 5)
  when 2
    @your_wallet.add_money(@your_bet.amount.to_i * 2)
  when 3
    @your_wallet.add_money(@your_bet.amount.to_i * 2)
  when 4
    @your_wallet.add_money(@your_bet.amount.to_i * 3)
  when 5
    @your_wallet.add_money(@your_bet.amount.to_i * 2)
  when 6
    @your_wallet.add_money(@your_bet.amount.to_i * 3)
  when 7
    @your_wallet.add_money(@your_bet.amount.to_i * 50)
  when 8
    @your_wallet.add_money(@your_bet.amount.to_i * 10)
  end
end
class Wallet
  attr_accessor :balance, :profit

  def initialize amount
    @balance = amount
    @profit = 0
  end

  def add_money amount
    @balance = @balance + amount
  end

  def subtract_money amount
    @balance = @balance - amount
  end
  
end
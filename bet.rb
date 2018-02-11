class Bet
  attr_accessor :amount, :selections

  def initialize 
    @amount = 0
    @selections = []
  end

  def print_selections 
    str = ""
    @selections.each {|element| str << "#{element} "}
    str
  end

end
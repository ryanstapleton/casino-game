class Spin

  attr_reader :results

  def initialize
    @results = Array.new(9) {rand(1..8)}
  end

  def again
    @results = Array.new(9) {rand(1..8)}
  end 
end
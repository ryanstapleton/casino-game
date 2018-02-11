class Game
  attr_writer :done, :play_again

  def initialize
    @done = false
    @play_again = false
  end

  def done?
    @done
  end

  def play_again?
    @play_again
  end

end
class Game
  attr_reader :number
  attr_accessor :guess
  def initialize
    @number = rand(0..100)
    @guess = nil
    @count = 0
  end

  def compare_guess
    case guess <=> number
      when 1
        "Guess is too high."
      when -1
        "Guess is too low."
      when 0
        "That is correct!"
    end
    count += 1
  end

end

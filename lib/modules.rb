module Board 

  COLOR_OPTIONS = ["Red", "Blue", "Green", "Yellow", "Violet", "Orange"]

  INDICATOR_PEGS = ["Black", "White"]

  def code_breaker_display(guesses, pegs)
    puts "\n\n"
    puts "Guess #{guesses.length}/10\n"
    guesses.each_with_index do |round, i|
      print "\n| "
      round.each do |guess|
        print guess + " | "
      end
      round.each
      print "#{pegs[i]}\n"
    end
    puts "\n"
  end
end

module Prompts

  input = nil

  def y_n(scenario)
    invalid = true
    while invalid
      invalid = false
      puts "\nWould you like to be the code breaker? (y/n)" if scenario == "role"
      if scenario == "code breaker"
        puts "Congrats #{self.code_breaker.name}}, you've successfully guessed the code and won!\n\n"
        puts "Would you like to play again? (y/n)"
      end
      if scenario == "coder"
        puts "Congrats #{self.coder.name}, you've stumped the code breaker and won!\n\n"
        puts "Would you like to play again? (y/n)"
      end
      input = gets.chomp.downcase
      unless input == "y" || input == "n"
        Game.invalid_input
        invalid = true
      end
    end
    return input
  end

  def get_human_array(array)
    self.code_length.times do
      invalid = true
      while invalid do 
        unless self.code.length == code_length
          puts "\n#{@human_player.name}'s turn to create a code by selecting from the list of colors:"
        else
          puts "\nCurrent guess: #{array}"
          puts "\n#{@human_player.name}'s turn to select a color for your guess from the following list:"
        end
        puts "#{self.free_colors.join(", ")}\n"
        color = gets.chomp.capitalize
        self.free_colors.each do |free|
          invalid = false if color == free
        end
        Game.invalid_input if invalid == true
      end
      array.push(self.free_colors.delete(color))
    end
    return array
  end
end
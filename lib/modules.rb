module Board 

  CODE_LENGTH = 4

  COLOR_OPTIONS = ["Red", "Blue", "Green", "Yellow", "Violet", "Orange"]

  TOTAL_COMBINATIONS = COLOR_OPTIONS.repeated_permutation(CODE_LENGTH).to_a

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

  def colored_pegs (guess_array, code_array)
    temp_guess = guess_array
    temp_code = code_array
    temp_removed = 0

    #Check correct color and position
    self.correct_counter = code_array.each_with_index.reduce({}) do |peg_obj, (code_color, i)|
      peg_obj[INDICATOR_PEGS[0]] ||= 0 #from Board module
      peg_obj[INDICATOR_PEGS[1]] ||= 0
      if code_color == guess_array[i]
        peg_obj[INDICATOR_PEGS[0]] += 1
        temp_guess.delete_at(i - temp_removed)
        temp_code.delete_at(i - temp_removed)
        temp_removed += 1
      end
      peg_obj
    end

    #Check correct color
    self.correct_counter = temp_code.each_with_index.reduce(self.correct_counter) do |peg_obj, (code_color, i)|
      temp_guess.each_with_index do |guess_color, j|
        if code_color == guess_color
          peg_obj[INDICATOR_PEGS[1]] += 1
          temp_guess.delete_at(j)
          break
        end
      end
      peg_obj
    end
  end

  def minimax(position, depth = 0, maximizing_player = 0)
    return 1
  end
end

module Prompts
  include Board

  input = nil

  def y_n(scenario)
    invalid = true
    while invalid
      invalid = false
      puts "\nWould you like to be the code breaker? (y/n)" if scenario == "role"
      if scenario == "code breaker"
        puts "Congrats #{self.code_breaker.name}, you've successfully guessed the code and won!\n\n"
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
        puts "#{COLOR_OPTIONS.join(", ")}\n"
        color = gets.chomp.capitalize
        color_index = nil
        COLOR_OPTIONS.each_with_index do |valid_color, i|
          if color == valid_color
            invalid = false
            color_index = i
            break
          end
        end
        Game.invalid_input if invalid == true
      end
      array.push(COLOR_OPTIONS[color_index])
    end
    return array
  end
end
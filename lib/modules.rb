module Board 

  CODE_LENGTH = 4

  COLOR_OPTIONS = ["Red", "Blue", "Green", "Yellow", "Violet", "Orange"]

  TOTAL_COMBINATIONS = COLOR_OPTIONS.repeated_permutation(CODE_LENGTH).to_a

  INDICATOR_PEGS = ["B", "W", ""]

  combine_pegs = INDICATOR_PEGS.repeated_combination(CODE_LENGTH).to_a
  PEG_COMBINATIONS = combine_pegs.map { |combo| combo.join }

  def code_breaker_display(guesses, pegs)
    puts "\n\n"
    puts "Guess #{guesses.length}/10\n"
    guesses.each_with_index do |round, i|
      print "\n| "
      round.each do |guess|
        print guess + " | "
      end
      round.each
      print "Correct Pegs: #{pegs[i]}\n"
    end
    puts "\n"
  end

  def colored_pegs (guess_array, code_array)
    temp_guess = guess_array.dup
    temp_code = code_array.dup
    temp_removed = 0

    #Check correct color and position
    self.correct_counter = code_array.each_with_index.reduce("") do |peg_obj, (code_color, i)|
      if code_color == guess_array[i]
        peg_obj << INDICATOR_PEGS[0]
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
          temp_guess.delete_at(j)
          peg_obj << INDICATOR_PEGS[1]
          break
        end
      end
      peg_obj
    end
  end

  #Find the position with the smallest value for each of its possible scores given every pin combination
  def minimax(position, best_score)
    removed_storage = []

    #Since none correct is most likely the smallest number removed for each guess, I used a greedy approach and check the none correct value first incase there is pruning
    PEG_COMBINATIONS.reverse.each do |peg_combo|
      removed_counter = 0
      self.possible_codes.each do |combo|
        colored_pegs(combo, position)
        unless peg_combo == self.correct_counter
          removed_counter += 1
        end
      end
      removed_storage.push(removed_counter)
      break if removed_counter < best_score #Prune codes that return a value lower than the current best score
    end
    score = removed_storage.min
    return score
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
module Board 

  COLOR_OPTIONS = ["Red", "Blue", "Green", "Yellow", "Violet", "Orange"]

  INDICATOR_PEGS = ["Black", "White"]

  def code_breaker_display(guesses, pegs)
    puts "\n\n"
    puts "Guess #{guesses.length}/10\n"
    guesses.each do |round|
      print "\n| "
      round.each do |guess|
        print guess + " | "
      end
      print "pegs\n"
    end
    puts "\n"
  end
end
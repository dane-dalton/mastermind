module Board 

  COLOR_OPTIONS = ["Red", "Blue", "Green", "Yellow", "Violet", "Orange"]

  INDICATOR_PEGS = ["Black", "White"]

  def code_breaker_display(guesses, pegs)
    puts "\n\n"
    guesses.each do |round|
      print "|"
      round.each do |guess|
        print guess + "|"
      end
      print " pegs\n"
    end
    puts "\n\n"
  end
end
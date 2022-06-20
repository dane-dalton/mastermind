module Board 

  color_options = ["Red", "Blue", "Green", "Yellow", "Violet", "Orange"]

  indicator_pegs = ["Black", "White"]

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
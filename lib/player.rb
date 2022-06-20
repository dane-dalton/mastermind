require_relative 'board.rb'

class Player 
  
  include Board

  attr_accessor :name

  def initialize
    @wins = 0
  end

end

class Human < Player
  def choose_name
    puts "What is your name?"
    self.name = gets.chomp
  end
end

class Computer < Player
  def initialize
    @name = "Computer"
  end
end
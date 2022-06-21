require_relative 'board.rb'
require_relative 'player.rb'

class Game
  include Board

  attr_reader :code_length

  attr_accessor :free_colors, :code_breaker, :coder

  def initialize()
    @free_colors = nil
    @code = []
    @code_length = 4
    @guess = []
    @human_player = Human.new
    @computer_player = Computer.new
    @code_breaker = nil
    @coder = nil
  end

  def play
    puts "Welcome to Mastermind! You'll be facing up against a robot."
    @human_player.choose_name
    choose_role
    choose_code(self.coder)
    p self.code
    choose_guess(self.code_breaker)
    p self.guess

  end

  private
    attr_accessor :code, :guess

    def choose_role
      invalid = true
      while invalid
        invalid = false
        puts "Would you like to be the code breaker? (y/n)"
        input = gets.chomp.downcase
        unless input == "y" || input == "n"
          Game.invalid_input
          invalid = true
        end
      end
      if input == "y"
        self.code_breaker = @human_player
        self.coder = @computer_player
      else
        self.code_breaker = @computer_player
        self.coder = @human_player
      end
    end

    def choose_code(player)
      if player.name == "Computer"
        set_code_computer
      else
        self.code = set_human
      end
    end

    def choose_guess(player)
      if player.name == "Computer"
        set_guess_computer
      else
        self.guess = set_human
      end
    end

    def set_code_computer
      self.free_colors = COLOR_OPTIONS.clone
      free_color_counter = 6
      self.code_length.times do
        color_pick = rand(free_color_counter)
        self.code.push(self.free_colors.delete_at(color_pick))
        free_color_counter -= 1
      end
    end

    def set_human
      self.free_colors = COLOR_OPTIONS.clone
      array = []
      self.code_length.times do
        invalid = true
        while invalid do 
          unless self.code.length == code_length
            puts "\nSelect a color for your code with the following options:"
          else
            puts "\nCurrent guess: #{array}"
            puts "\nSelect a color for your guess with the following options:"
          end
          puts "#{self.free_colors.join(", ")}"
          color = gets.chomp.capitalize
          self.free_colors.each do |free|
            invalid = false if color == free
          end
          Game.invalid_input if invalid == true
        end
        array.push(self.free_colors.delete(color))
      end
      return array.clone
    end

    #Computer takes random guesses for now
    def set_guess_computer
      self.free_colors = COLOR_OPTIONS.clone
      self.guess = []
      free_color_counter = 6
      self.code_length.times do
        color_pick = rand(free_color_counter)
        self.guess.push(self.free_colors.delete_at(color_pick))
        free_color_counter -= 1
      end
    end

    def self.invalid_input
      p "\nError. Invalid input."
    end
end


game = Game.new
game.play
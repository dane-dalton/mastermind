require_relative 'board.rb'
require_relative 'player.rb'

class Game
  include Board

  attr_accessor :free_colors

  def initialize()
    @free_colors = color_options.clone
    @code = Array.new(4)
    @human_player = Human.new
    @computer_player = Computer.new
    @code_breaker = nil
    @coder = nil
  end

  def play
    puts "Welcome to Mastermind! You'll be facing up against a robot."
  end

  def choose_code(player)
    if player.name == "Computer"
      set_code_computer
    else
      set_code_human
    end
  end

  private
    def code
      @code
    end

    def set_code_computer
      free_color_counter = 6
      @code.each do |color|
        color_pick = rand(free_color_counter)
        @code[color] = @free_colors.delete_at(color_pick)

        free_color_counter -= 1
      end
      @code
    end

    def set_code_human
      @code.each do |color|
        invalid = true
        while invalid do 
          puts "Select a color for your code with the following options:"
          puts "#{@free_colors.join(", ")}"
          color = gets.chomp.capitalize
          @free_colors.each do |free|
            invalid = false if color == free
          end
          Game.invalid_input if invalid == true
        end
        @free_colors.delete(color)
      end
      @code
    end

    def self.invalid_input
      p "Error. Please select a color available."
    end
end
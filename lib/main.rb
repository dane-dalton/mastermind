require_relative 'modules.rb'
require_relative 'player.rb'

class Game
  include Board
  include Prompts

  attr_reader :code_length

  attr_accessor :code_breaker, :coder, :guess_storage, :correct_counter, :correct_storage, :possible_codes, :unused_codes

  def initialize()
    @code = []
    @code_length = CODE_LENGTH
    @guess = []
    @guess_storage = []
    @correct_counter = ""
    @correct_storage = []
    @rounds = 10
    @human_player = Human.new
    @computer_player = Computer.new
    @code_breaker = nil
    @coder = nil
    @possible_codes = TOTAL_COMBINATIONS.dup #Total possible codes = 1296
    @unused_codes = TOTAL_COMBINATIONS.dup
  end

  def play
    puts "\nWelcome to Mastermind! You'll be facing up against a robot."
    @human_player.choose_name
    choose_role
    choose_code(self.coder)
    start_guesses
    coder_winner unless check_winner?(self.correct_counter)
  end

  #Starts the guessing period for the code breaker. Runs the set amount of rounds.
  def start_guesses
    self.rounds.times do
      choose_guess(self.code_breaker)
      p self.code
      colored_pegs(self.guess, self.code) #gets number correct
      self.guess_storage.push(self.guess)
      self.correct_storage.push(self.correct_counter)
      code_breaker_display(self.guess_storage, self.correct_storage) #from Board module
      if check_winner?(self.correct_counter)
        input = y_n("code breaker")
        play_again(input)
        break
      end
    end
  end

  def check_winner?(num_correct)
    num_correct == "BBBB"
  end

  def self.invalid_input
    puts "\nError. Invalid input."
  end

  private

    attr_accessor :code, :guess, :rounds

    def choose_role
      input = y_n("role")
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
        self.guess = set_guess_computer(self.guess)
      else
        self.guess = set_human
      end
    end

    def set_code_computer
      self.code_length.times do
        color_pick = rand(COLOR_OPTIONS.length)
        self.code.push(COLOR_OPTIONS[color_pick])
      end
    end

    #Setting the code and guessing the code are similar, so this method fills an array and assigns it to either the code or the guess depending on the users role
    def set_human
      array = []
      get_human_array(array) #from Prompt module
      return array.dup
    end

    #Computer takes random guesses for now
    def set_guess_computer(cpu_guess)
      #First guess is always 1122
      if self.guess_storage == []
        cpu_guess = [COLOR_OPTIONS[0], COLOR_OPTIONS[0], COLOR_OPTIONS[1], COLOR_OPTIONS[1]]
        self.unused_codes.delete(cpu_guess)
        return cpu_guess
      end

      #Remove all possible codes that would not yield the same response as the guess if the guess were the code
      temp_correct_counter = self.correct_counter
      self.possible_codes.delete_if do |combo|
        colored_pegs(combo, cpu_guess)
        !(temp_correct_counter == self.correct_counter)
      end


      best_score = -(1.0/0.0)

      self.unused_codes.each do |unused_code|
        score = minimax(unused_code)
        if score > best_score
          best_score = score
          cpu_guess = unused_code
        elsif score == best_score && self.possible_codes.include?(unused_code) && !(self.possible_codes.include?(cpu_guess))
          cpu_guess = unused_code
        end
      end

      self.unused_codes.delete(cpu_guess)
      return cpu_guess
    end

    def coder_winner
      input = y_n("coder")
      play_again(input)
    end

    def play_again(y_or_n)
      if y_or_n == "y"
        game = Game.new
        game.play
      end
    end
end


game = Game.new
game.play

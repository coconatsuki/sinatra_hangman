require './text'
require './system'
require 'json'
require 'pry'

class Game

  SAVE_FILE = 'save.json'

  attr_accessor :new_word, :system, :count

  def initialize
    @system = System.new
    @count = 12
    @new_word = ''
  end

  def start_game
    @new_word = @system.generate_word
  end

  def play(letter)
    if @count > 0 && !victory?
      one_turn(letter)
    end
  end

  def one_turn(letter)
    @count -= 1
    play_letter(letter)
  end

  def play_letter(letter)
    if @system.present_in_the_word?(letter, new_word)
      @system.change_display(letter, new_word)
    end
    @system.update_used_letter(letter)
  end

  def victory?
    @system.victory?(@new_word)
  end

  def game_over?
    @count == 0
  end
end

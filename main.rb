require 'sinatra'
require 'sinatra/reloader' if development?
require_relative './game'

game = Game.new
game.start_game
image_source = "/images/0.png"

@@message = ''


get '/reset' do
  game = Game.new
  game.start_game
  @@message = ''
  redirect to('/')
end

get '/add_letter' do
  @@message = ''
  if params['letter']
    letter = params['letter'].upcase
    if game.system.valid_letter?(letter)
      game.play(letter)
    elsif !game.system.available?(letter)
      already_used_message
    elsif !game.system.valid?(letter)
      non_valid_letter_message
    else
      wrong_letter_message
    end
  end
  redirect to('/')
end

get '/' do
        #update variables:
  word_to_display = game.system.display_word
  count = game.count
  used_letters = game.system.used_letters_to_s
      #check_victory/game_over :
  if game.victory?
    victory_message
  elsif game.game_over?
    game_over_message(game.new_word)
  end

    #change image display
    if game.victory?
      image_source = "/images/victory.png"
    elsif count == 11
      image_source = "/images/1.png"
    elsif count == 10
      image_source = "/images/2.png"
    elsif count == 9
      image_source = "/images/3.png"
    elsif count == 8
      image_source = "/images/4.png"
    elsif count == 7
      image_source = "/images/5.png"
    elsif count == 6
      image_source = "/images/6.png"
    elsif count == 5
      image_source = "/images/7.png"
    elsif count == 4
      image_source = "/images/8.png"
    elsif count == 3
      image_source = "/images/9.png"
    elsif count == 2
      image_source = "/images/10.png"
    elsif count == 1
      image_source = "/images/11.png"
    elsif count == 0
      image_source = "/images/12.png"
    else
      image_source = "/images/0.png"
    end

  erb :index, :locals => { word_to_display: word_to_display, message: @@message, count: count, used_letters: used_letters, image_source: image_source }
end

def already_used_message
  @@message = "ERROR : You already tried this letter."
end

def non_valid_letter_message
  @@message = "ERROR : This is not a valid letter. Try again !"
end

def victory_message
  @@message = "You wiiiiiiiiinnn !!! "
end

def wrong_letter_message
  @@message = "This letter is not in the word."
end

def game_over_message(word)
  @@message = "You LOST. The word was '#{ word }'. Press 'start a new game', if you dare."
end

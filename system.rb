class System

  attr_accessor :word_to_display, :used_letters

  def initialize
    @word_to_display = []
    @used_letters = []
  end

  def generate_word
    dico_words = File.open('dico.txt', 'r').readlines
    new_word = dico_words.select { |el| el.length >= 5 && el.length <= 12 }.sample.chomp.upcase
    @word_to_display = Array.new(new_word.chomp.length)
    new_word
  end

  def display_word
    @word_to_display.map do |letter|
      letter.nil? ? ' _ ' : letter
    end.join(" ")
  end

  def used_letters_to_s
    if @used_letters.empty?
      ''
    else
      @used_letters.join(' ')
    end
  end

  def valid_letter?(letter)
    valid?(letter) && available?(letter)
  end

  def update_used_letter(letter)
      @used_letters << letter
      @used_letters.join(" ")
  end

  def valid?(letter)
    letter.upcase =~ /^[A-Z]$/
  end

  def available?(letter)
    !@used_letters.include?(letter)
  end

  def present_in_the_word?(letter, new_word)
    new_word.include?(letter)
  end

  def change_display(letter, new_word)
    new_word_array = new_word.chars
    new_word_array.each_with_index do |el, i|
      if el == letter
        @word_to_display[i] = el
      end
    end
  end

  def victory?(new_word)
    new_word.chars == @word_to_display
  end
end

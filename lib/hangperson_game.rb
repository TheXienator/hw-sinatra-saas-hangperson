class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end

  attr_accessor :word, :guesses, :wrong_guesses, :word_with_guesses, :check_win_or_lose
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @word_with_guesses = '-' * word.length
    @check_win_or_lose = :play
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess(letter)
    if letter !~ /^[A-Za-z]$/ 
      raise ArgumentError.new("Not a valid letter")
    end

    letter = letter.downcase

    if @guesses.include? letter or @wrong_guesses.include? letter
      return false
    end

    if @word.include? letter
      @guesses += letter
      for i in 0..@word.length - 1
        if @word[i] == letter
          @word_with_guesses[i] = letter
          if @word == @word_with_guesses
            @check_win_or_lose = :win
          end
        end
      end
    else
      @wrong_guesses += letter
      if @wrong_guesses.length >= 7
        @check_win_or_lose = :lose
      end
    end
    return true
  end

end

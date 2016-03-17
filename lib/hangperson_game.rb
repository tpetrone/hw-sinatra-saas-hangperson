class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end

  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(word)
    self.word = word
    self.guesses = ''
    self.wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess(letter)

    if letter.nil? || letter.size==0 || !(letter =~ /[a-z]/i)
      raise ArgumentError
    end

    letter.downcase!
    if self.guesses[letter] || self.wrong_guesses[letter]
      return false
    end

    if word[letter]
      self.guesses << letter
    else
      self.wrong_guesses << letter
    end
    return true
  end


  def word_with_guesses
    self.word.split(//).map do |letter|
      if guesses[letter]
        letter
      else
        "-"
      end
    end.join
  end



  def check_win_or_lose

    if self.wrong_guesses.size >= 7
      :lose
    elsif !word_with_guesses["-"]
      :win
    else
      :play
    end
  end


end

class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
  # Get a word from remote "random word" service
  # def initialize()
  # end
  attr_accessor :guesses, :wrong_guesses, :total, :letters, :attempt

  def initialize(word)
    @word = word
    @wrong_guesses = ""
    @guesses = ""
    @total = 0 
    @letters = Set.new
    letters = word.chars.uniq
    @attempt = "-" * word.length
  end

  def word
    @word
  end

  def guess g
    unless g != nil and g != "" and g.match(/^[A-Za-z]+$/)
      raise ArgumentError.new("Not a valid guess")
    end
    g = g.downcase
    if word.include? (g)
      if not guesses.include? (g)
        @guesses = guesses + g
        count = 0
        word.split('').each { 
          |c| 
          if c == g 
            attempt[count] = g
          end 
          count += 1
        }
        puts attempt
        return true
      else 
        return false
      end
    else 
      if not wrong_guesses.include? (g)
        @wrong_guesses = wrong_guesses + g
        @total = total + 1
        return true
      else 
        return false
      end
    end
  end

  def word_with_guesses 
    attempt
  end

  def check_win_or_lose 
    if total >= 7 
      return :lose
    elsif attempt == word
      return :win
    else 
      return :play
    end
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end

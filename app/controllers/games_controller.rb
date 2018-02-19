require 'json'
require 'open-uri'


class GamesController < ApplicationController
  def new
    @rnd_letters = 10.times.map{ ('A'..'Z').to_a.sample }
  end

  def score
    @guessed = params[:word].upcase
    @random = params[:rnd_letters].upcase
    dict_url = "https://wagon-dictionary.herokuapp.com/#{@guessed}"
    resp_serialized = open(dict_url).read
    resp = JSON.parse(resp_serialized)

    if !resp["found"]
      @scenario = 'wrong'
      return
    end
    guess_array = @guessed.split('')
    guess_array.each do |char|

      if guess_array.count(char) > @random.count(char)
        @scenario = 'ko'
        # raise
        return
      end
    end

    @scenario = 'ok'
  end
end

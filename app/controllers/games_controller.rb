require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ("A".."Z").to_a.sample
    end
  end

  def score
    # raise
    @word = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
      response = open(url).read
      response2 = JSON.parse(response)
      # result = { time: end_time - start_time, score: (attempt.length / (end_time - start_time)), message: "Well Done!" }
      if response2["found"] == false
        @score = 0
        @result = "This is not an English word"
      elsif params[:word].upcase.chars.any? { |e| params[:word].upcase.count(e) > params[:letters].count(e) }
        @score = 0
        @result = "This is not in the grid"
      else
        @result = "Nice!"
        @score = params[:word].length
      end
  end
end

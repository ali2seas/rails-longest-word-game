require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @lett = (rand(1..1)..rand(5..10)).map {[*("a".."z")].sample}
    @letters = @lett.join
  end

  def score
    @word = params[:word]
    @url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    @file = open(@url).read
    @hash = JSON.parse(@file)
    if included
      if @hash["found"]
        @score = @hash["length"]
      else
        @score = "Not an English word"
      end
    else
      @score = "out of the grid"
    end
  end

  def included
    @grid = params[:grid].chars
    @grid.each do |letter|
      if @word.include? (letter)
        @word.slice!(@word.index(letter))
      end
    end
    if @word.length == 0
      return true
    else
      return false
    end
  end
end

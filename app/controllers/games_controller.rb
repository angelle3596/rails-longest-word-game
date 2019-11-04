require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @name = params[:name]
    @letters = params[:letters]
    @grid_word = inside_grid?(@name, @letters)
    @english_word = english_word?(@name)
    @result = result(@name)
  end
  #   if included?
  #     if english_word?
  #       "Congratulations! #{params[:name]} is a valid English word!"
  #     else
  #       "Sorry but #{params[:name]} does not seem to be a valid English word..."
  #     end
  #   else
  #     "Sorry but #{params[:name]} can't be build out of @letters"
  #   end
  # end

  private

  def inside_grid?(name, letters)
    name.chars.all? { |letter| name.count(letter) <= letters.count(letter.capitalize) }
  end

  def english_word?(name)
    response = open("https://wagon-dictionary.herokuapp.com/#{name}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def result(name)
    name.size**2
  end
end

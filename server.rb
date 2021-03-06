require "sinatra"
require "pry" if development? || test?
require "sinatra/reloader" if development?
require_relative 'game.rb'

set :bind, '0.0.0.0'  # bind to all interfaces

use Rack::Session::Cookie, {
  secret: "keep_it_secret_keep_it_safe",
}

get '/' do
  if session[:player_score].nil? && session[:computer_score].nil?
    erb :index
  elsif !session[:player_score].nil? && session[:player_score] >= 2
    session[:winner] = "Player Wins"
    erb :results
  elsif !session[:computer_score].nil? && session[:computer_score] >= 2
    session[:winner] = "Computer Wins"
    erb :results
  else
    erb :index
  end
end

post '/' do
  @game = Game.new(params[:choice])
  @game.determine_winner
  if @game.result == "Computer"
    if session[:computer_score].nil?
      session[:computer_score] = 1
    else
      session[:computer_score] += 1
    end
    session[:message] = "Computer Wins!"
  elsif @game.result == "Player"
    if session[:player_score].nil?
      session[:player_score] = 1
    else
      session[:player_score] += 1
    end
    session[:message] = "Player Wins!"
  else
    # @game.result == "Tie"
    session[:message] = "It's a Tie!"
  end
  erb :index
  redirect '/'
end

post '/results' do
  if params[:yes_or_no] == "Yes"
    session[:message] = ""
    session[:player_score] = 0
    session[:computer_score] = 0
    redirect '/'
  else
    url = "https://www.youtube.com/watch?v=Eo-KmOd3i7s"
    redirect url
  end
end

require "sinatra"
require "pry" if development? || test?
require "sinatra/reloader" if development?
require_relative 'game.rb'

set :bind, '0.0.0.0'  # bind to all interfaces

use Rack::Session::Cookie, {
  secret: "keep_it_secret_keep_it_safe"
}

get '/' do
  if session[:visit_count].nil?
    session[:visit_count] = 1
  else
    session[:visit_count] += 1
  end

  erb :index
end

post '/choose' do
  @game = Game.new(params[choice])
  @game.determine_winner
  if @game.result == "Computer"
    session[:computer_score] += 1
  elsif @game.result == "Player"
    session[:player_score] += 1
  else @game.result == "Tie"

  end
end

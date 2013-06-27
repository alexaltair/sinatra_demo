require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'open-uri'

get '/' do 
  @name = "Alex Altair"
  erb :home
end

def get_model(q)
  url = "http://www.omdbapi.com/?s=#{URI.escape(q)}"
  results = JSON.load(open(url).read)
  results["Search"]
end

get '/search' do 
  @query = params[:q]
  @movies = get_model(@query)
  erb :result
end

def get_movie(link)
  url = "http://www.omdbapi.com/?i=#{URI.escape(link)}"
  JSON.load(open(url).read)
end

get '/movie/:imdbID' do
  @link = params[:imdbID]
  @movie = get_movie(@link)
  @tomato_movie = get_movie("#{@link}&tomatoes=true")
  @tomato = @tomato_movie["tomatoRating"]
  erb :movie
end
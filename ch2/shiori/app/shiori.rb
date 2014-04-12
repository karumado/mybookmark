require 'sinatra/base'

class Shiori < Sinatra::Base
  get '/' do
    erb :index
  end
end

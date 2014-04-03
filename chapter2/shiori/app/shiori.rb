require 'sinatra/base'

class Shiori < Sinatra::Base
  get '/' do
    'hi'
  end
end

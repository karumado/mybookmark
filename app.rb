require 'sinatra/base'
require 'pry'

class App < Sinatra::Base

    configure :development do
        puts 'development mode!'
    end

    configure :production do
        puts 'production mode!'
    end

    configure do
        puts 'all configure!'
    end

    get '/' do
        binding.pry
        'hi'
    end
end

require 'sinatra/base'
require 'active_record'
require 'will_paginate'
require_relative 'models/bookmark'
require_relative 'db'

class Shiori < Sinatra::Base
  register WillPaginate::Sinatra

  # パブリックフォルダの設定
  set :public_folder, File.expand_path(
        File.join(root, '..', 'public'))

  # Viewで利用する　ヘルパー関数
  helpers do
    def h(text)
      Rack::Utils.escape_html(text)
    end
  end

  configure do
    DB.connect(
      File.expand_path(File.join(root, '..',)),ENV['RACK_ENV'])
  end

  get '/' do
    @bookmarks = Bookmark.order('id DESC').page(params[:page])
    erb :index
  end

  get '/new' do
    erb :new
  end

  post '/create' do
    begin
      # データを保存できた場合は '/' へリダイレクトする
      Bookmark.create!(url: params[:url])
      redirect '/'
    rescue ActiveRecord::RecordInvalid => e
      # データの保存に失敗したら再度登録画面を描画する
      @bookmark = e.record
      erb :new
    end
  end
end

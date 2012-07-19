require 'sinatra'

class GoFishUiInit < Sinatra::Base

  get '/' do
    erb :index
  end

  get '/go_fish_main' do
    @stuff = "good stuff"
    erb :layout_gf
  end

  get '/process_page' do
    erb :layout_gf
    end
end

GoFishUiInit.run!


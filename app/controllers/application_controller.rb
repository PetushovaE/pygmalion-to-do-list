require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
  	set :views, "app/views"
  	set :public_dir, "public"
    set :session_secret, 'katya'
    enable :sessions
  end

  get "/" do
  	erb :index
  end

  	helpers do

		def is_logged_in?
      # binding.pry
			!!session[:user_id]
		end

		def current_user
			@current_user ||= User.find(session[:user_id])
		end
	end
end

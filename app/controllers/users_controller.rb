
require 'pry'
class UsersController < ApplicationController

		get '/signup' do
			if !session[:user_id]
				erb :'/users/signup'
			else
				redirect to '/tasks'
			end
		end
		
		post '/signup' do
			if params[:username] == "" || params[:email] == "" || params[:password] == ""
      			erb :'/users/signup', locals: {message: "Please sign up before you sign in"}
      		else
				@user = User.new(username: params[:username], email: params[:email], password: params[:password])
				@user.save
			# binding.pry
				session[:user_id] = @user.id
				redirect '/tasks'
			end
		end

		get '/login' do
			if !is_logged_in?
				erb :'/users/login'
			else
				redirect '/tasks'
			end
		end

		post '/login' do
			user = User.find_by(username: params[:username])
			if user && user.authenticate(params[:password])
				session[:user_id] = user.id
				redirect '/tasks'
			else
				erb :'/users/signup', locals: {message: "There seems to be an error. Please try again."}
			end
		end
		
		get '/logout' do
    		if session[:user_id] != nil
      			session.destroy
      			binding.pry
      			redirect to '/'
    		end
  		end
end


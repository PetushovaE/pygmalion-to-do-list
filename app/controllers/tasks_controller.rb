class TasksController < ApplicationController
		
	get '/tasks' do
		if is_logged_in?
			@tasks = Task.all
			erb :'/tasks/index'
		else
			erb :'/users/login', locals: {message: "Access denied. Please log-in to view."}
		end
	end

	get '/tasks/new' do
		if is_logged_in?
			erb :'/tasks/new'
		else
			erb :'/users/login', locals: {message: "Access denied. Please log-in to view."}
		end
	end
	
	post '/tasks' do
		if params[:name] == "" || params[:content] == ""
			erb :'/tasks/new', locals: {message: "There seems to be an error. Please try again."}
		else
			user = current_user
			@task = Task.create(name: params[:name], content: params[:content], user_id: user.id)
			redirect "/tasks/#{@task.id}"
		end
	end

	get '/tasks/:id' do
		if is_logged_in?
			@task = Task.find(params[:id])
			erb :'/tasks/show'
		else
			erb :'/users/login', locals: {message: "Access denied. Please log-in to view."}
		end
	end

	get '/tasks/:id/edit' do
		if is_logged_in?
			@task = Task.find_by_id(params[:id])
		if @task.user_id == session[:user_id]
			erb :'/tasks/edit'
		else
			erb :'/tasks', locals: {message: "Sorry, you do not have permission to edit this task."}
			end
		else
			erb :'/users/login', locals: {message: "Access denied. Please log-in to view."}
		end
	end

	patch '/tasks/:id' do
		if params[:name] == "" || params[:content] == ""
			@task = Task.find_by_id(params[:id])
			erb :'/tasks/edit', locals: {message: "There seems to be an error. Please try again."}
		else
			@task = Task.find(params[:id])
			@task.update(name: params[:name], content: params[:content])
			redirect "/tasks/#{@task.id}"
		end
	end
	
	delete '/tasks/:id/delete' do
		@task = Task.find_by_id(params[:id])
		@task.delete
	redirect '/tasks'
	end
end

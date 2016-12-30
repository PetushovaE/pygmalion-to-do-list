class TasksController < ApplicationController
		
	get '/tasks' do
		if is_logged_in?
			@tasks = current_user.tasks
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
	
	post '/task' do
		if params[:name] == "" || params[:content] == ""
			erb :'/tasks/new', locals: {message: "There seems to be an error. Please try again."}
		else
			user = current_user
			@task = Task.create(name: params[:name], content: params[:content], user_id: user.id)
			redirect "/tasks/#{@task.id}"
		end
	end

	get '/tasks/:id' do
		@task = Task.find(params[:id])
		if is_logged_in? 
			# && @task.user == current_user
			erb :'/tasks/show'		
		else
			erb :'/users/login', locals: {message: "Access denied. Please log-in to view."}
		end
	end

	get '/tasks/:id/edit' do
		@task = Task.find_by_id(params[:id])
		if is_logged_in? 
		if @task.user_id == session[:user_id]
			erb :'/tasks/edit'
		else
			erb :'/tasks/show', locals: {message: "Sorry, you do not have permission to edit or delete this task."}
			end
		else
			erb :'/users/login', locals: {message: "Access denied. Please log-in to view."}
		end
	end

	get '/tasks/:id/warning' do
		@task = Task.find_by_id(params[:id])
		erb :'tasks/warning'
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
    	if is_logged_in? && @task.user_id == current_user.id
    		@task.delete
    	end
    		redirect '/tasks'
  	end
end




class UserController < ApplicationController

	get '/' do 
		redirect '/user/login'
	end

	get '/login' do
		erb :login
	end

	get '/register' do 
		erb :register
	end

	post '/login' do 
		@pw = params[:password]

		@user = User.find_by(username: params[:username])
		if @user && @user.authenticate(@pw)
			session[:username] = @user.username
			session[:logged_in] = true
			session[:user_id] = @user.id
			session[:message] = "logged in as #{@user.username}"
			redirect '/items'
		else
			session[:message] = "invalid username or password, try again"
		end
	end

	post '/register' do 
		@user = User.new
		@user.username = params[:username]
		@user.password = params[:password]
		@user.save

		session[:logged_in] = true
		session[:username] = @user.username
		session[:user_id] = @user.id
		session[:message] = "thanks for signing up fam"

		redirect '/items'
	end

	get '/logout' do
		session[:username] = nil
		session[:logged_in] = false
		session[:user_id] = nil
		session[:message] = "successfully logged out"

		redirect '/user/login'
	end

end

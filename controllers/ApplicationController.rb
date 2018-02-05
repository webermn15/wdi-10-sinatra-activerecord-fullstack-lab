class ApplicationController < Sinatra::Base

	require 'bundler'
	Bundler.require

	ActiveRecord::Base.establish_connection(
		:adapter => 'postgresql',
		:database => 'item'
	)

	set :views, File.expand_path('../views', File.dirname(__FILE__))

	get '/' do 
		@page = 'todo'
		erb :hello
	end

end
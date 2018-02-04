class ApplicationController < Sinatra::Base

	require 'bundler'
	Bundler.require

	set :views, File.expand_path('../views', File.dirname(__FILE__))

	get '/' do 
		erb :home
	end

	not_found do 
		'404'
	end

end
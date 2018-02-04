class ApplicationController < Sinatra::Base

	require 'bundler'
	Bundler.require

	get '/' do 
		'server online'
	end

	not_found do 
		'404'
	end

end
class ItemController < ApplicationController 

	get '/' do 
		'item root'
	end

	get '/add' do 
		erb :add_item
	end

end
	
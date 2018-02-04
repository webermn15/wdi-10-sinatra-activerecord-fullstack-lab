class ItemController < ApplicationController 

	get '/' do 
		@page = "Add Item"
		@method = "POST"
		@action = "items/add"
		@placeholder = "enter a new item"
		@value = ""
		@buttontext = "add item"
		erb :add_item

	end

	post '/add' do 
		pp request.body
		'check your terminal'
	end

end
	
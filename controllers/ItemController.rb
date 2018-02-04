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

	get '/add' do 
		erb :add_item
	end

end
	
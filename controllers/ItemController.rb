class ItemController < ApplicationController 

	get '/' do 

		@items = Item.all

		# @items.to_json
		@page = 'item index'
		erb :item_index

	end

	get '/add' do 
		@page = "Add Item"
		@method = "POST"
		@action = "/items/add"
		@placeholder = "enter a new item"
		@value = ""
		@buttontext = "add item"
		erb :add_item
	end

	post '/add' do 
		pp params

		@item = Item.new
		@item.title = params[:title]
		@item.user_id = 1
		@item.save

		session[:message] = "You added item #{@item.id}"

		redirect '/items'
	end

	delete '/:id' do 
		@item = Item.find params[:id]
		@item.delete
		session[:message] = "You deleted item #{@item.id}"
		redirect '/items'
	end

	get '/edit/:id' do 
		@item = Item.find params[:id]
		@page = "edit item #{@item.id}"
		erb :edit_item
	end

	patch '/:id' do 
		@item = Item.find params[:id]
		@item.title = params[:title]
		@item.save
		session[:message] = "You updated item #{@item.id}"
		redirect '/items'
	end

end
	

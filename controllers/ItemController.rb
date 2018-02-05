class ItemController < ApplicationController 

	# FILTER: the code on this filter will be run on all item routes

	before do
		pp "HEY YOURE TRYING TO DO ITEM STUFF"
		if !session[:logged_in]
			session[:message] = "you must be logged in to do that "
			redirect '/user/login'
		end
	end

	get '/' do 
		@user = User.find session[:user_id]
		@items = @user.items.order(:id)

		# @items = Item.all

		@page = 'item index'
		erb :item_index

	end

	get '/ajax' do 
		erb :item_index_ajax
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
		@item.user_id = session[:user_id]
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
	

class ItemController < ApplicationController 

	# FILTER: the code on this filter will be run on all item routes

	before do
		pp "HEY YOURE TRYING TO DO ITEM STUFF"
		if !session[:logged_in]
			session[:message] = "you must be logged in to do that "
			redirect '/user/login'
		end
	end

	get '/ajax' do 
		erb :item_index_ajax
	end

	# json index route
	get '/j' do 
		@user = User.find session[:user_id]
		@items = @user.items.order(:id)
		# @items.to_json
		# building our API response
		resp = {
			status: {
				all_good: true,
				number_of_results: @items.length
			},
			items: @items
		}
		resp.to_json;
	end

	post '/j' do 
		@item = Item.new
		@item.title = params[:title]
		@item.user_id = session[:user_id]
		@item.save

		resp = {
			status: {
				all_good: true
				# you could put other information here
			},
			item: @item
		}

		resp.to_json
	end

	delete '/j/:id' do 
		@item = Item.find params[:id]
		@item.delete
		resp = {
			status: {
				all_good: true,
				message: "you deleted #{params[:id]}"
			}
		}

		@item.to_json
	end

	# api edit route

	get '/j/edit/:id' do 
		@item = Item.find params[:id]
		resp = {
			status: {
				all_good: true,
				message: "you are editing item #{params[:id]}"
			},
			item: @item
		}
		resp.to_json
	end

	patch '/j/:id' do 
		@item = Item.find_by(id:params[:id])
		@item.title = params[:title]
		@item.save
		resp = {
			status: {
				all_good: true,
				message: "updated item: #{params[:id]}"
			},
			item: @item
		}

		resp.to_json

	end

end
	

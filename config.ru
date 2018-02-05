require 'sinatra/base'
require 'sinatra/activerecord'

#controllers
require './controllers/ApplicationController'
require './controllers/ItemController'

#models
require './models/ItemModel'

map('/') {
	run ApplicationController
}
map('/items') {
	run ItemController
}
require 'sinatra/base'
require 'sinatra/activerecord'

require './controllers/ApplicationController'
require './controllers/ItemController'

map('/') {
	run ApplicationController
}
map('/items') {
	run ItemController
}
require 'sinatra/base'
require 'sinatra/activerecord'

require './controllers/ApplicationController'

map('/') {
	run ApplicationController
}
# This file is used by Rack-based servers to start the application.
require 'rubygems'
require 'sinatra'

set :environment, :production
set :port, 8080
disable :run, :reload

require 'acoplet'

run Sinatra::Application

require ::File.expand_path('../config/environment',  __FILE__)
run Eligant::Application

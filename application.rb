require 'sinatra'
require 'pry'
require 'mongoid'

# Load MongoDB configuration
Mongoid.load!('config/mongoid.yml')

# Load All Models
Dir[File.expand_path('models/*.rb', File.dirname(__FILE__))].each do |file|
  require file
end

# Load Routes - initializes actual sinatra app
require File.expand_path('routes.rb', File.dirname(__FILE__))

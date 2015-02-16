require 'sqlite3'
require 'pry'
require 'sinatra'
require 'rubygems'
require 'active_support/inflector'

DATABASE = SQLite3::Database.new("./database/convention_manager.db")

database = Dir["./database/*.rb"]
database.each do |file|
  require_relative file
end

models = Dir["./models/*.rb"]
models.each do |file|
  require_relative file
end

helpers = Dir["./helpers/*.rb"]
helpers.each do |file|
  require_relative file
end

helpers 

get "/" do
  
end


require 'sqlite3'
require 'pry'
require 'sinatra'
require 'rubygems'
require 'active_support/inflector'
require 'geocoder'
require_relative 'require_handler'

include RequireHandler

DATABASE = SQLite3::Database.new("./database/convention_manager.db")

req_rel("database")
req_rel("models")
req_rel("helpers")

helpers Dropdown

get "/" do
  erb :main
end

get "/create" do
  erb :create
end

get "/search" do
  erb :search
end

get "/view" do
  erb :view
end

get "/edit" do
  erb :edit
end

get "/delete" do
  erb :delete
end

get "/confirm" do
  erb :confirm
end
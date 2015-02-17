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

helpers Dropdown, StringToClass, FormCreate, GetMap, ViewFormat

before do
  if params[:type] == nil
    redirect to("/?type=none")
  end
end

get "/" do
  erb :main
end

get "/create" do
  @reqs = get_requirements(params[:type]) unless params[:type].nil?
  @convention_list = Convention.all
  @person_list = Person.all
  @panel_list = Panel.all
  erb :create
end

get "/new" do
  # case params[:type]
  # when "convention"
  #   @obj = Convention.new(params)
  #   @obj.get_lat_and_long(@obj.address)
  # when "panel"
  #   @obj = Panel.new(params)
  # when "person"
  #   @obj = Person.new(params)
  # end
  @obj = to_class(params[:type]).new(params)
  if params[:type] == "convention"
    @obj.get_lat_and_long(@obj.address)
  end
  erb :confirm_add
end

get "/search" do
  erb :search
end

get "/view" do
  @results = to_class(params[:type]).search_for("id", params[:id])
  @obj = @results[0]
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
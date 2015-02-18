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

helpers Dropdown, StringToClass, FormCreate, GetMap, ViewFormat, RedirectHelper, EditFormat

before do
  if params[:type] == nil
    redirect to("/?type=none")
  end
end

before "/new" do 
  if params[:correct] == "no"
    request.path_info = "/create"
  end
end

get "/" do
  erb :main
end

get "/create" do
  @reqs = get_requirements(params[:type])
  @convention_list = Convention.all
  @person_list = Person.all
  @panel_list = Panel.all
  erb :create
end

get "/new" do
  @obj = to_class(params[:type]).new(params)
  @obj.insert
  redirect_assist("view")
end

get "/search" do
  unless params[:id] == nil
    redirect_assist("view")
  end
  @reqs = get_requirements_with_id(params[:type])
  erb :search
end

get "/search_results" do
  if params[:field].nil? || params[:value].nil?
    redirect to("/search?#{params[:type]}")
  end
  @results = to_class(params[:type]).search_for("#{params[:field]}", params[:value])
  erb :search_results
end

get "/view" do
  @results = to_class(params[:type]).search_for("id", params[:id])
  @obj = @results[0]
  erb :view
end

get "/edit" do
  @results = to_class(params[:type]).search_for("id", params[:id])
  @obj = @results[0]
  erb :edit
end

get "/save" do
  @obj = to_class(params[:type]).new(params)
  @obj.save
  query_string = request.query_string
  redirect to("/view?#{query_string}")
end

get "/delete" do
  erb :delete
end

get "/confirm_add" do
  @obj = to_class(params[:type]).new(params)
  erb :confirm_add
end
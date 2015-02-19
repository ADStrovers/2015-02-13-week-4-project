require 'sqlite3'
require 'pry'
require 'sinatra'
require 'rubygems'
require 'active_support/inflector'
require 'geocoder'
require 'sinatra/partial'
require_relative 'require_handler'

include RequireHandler

set :partial_template_engine, :erb
enable :sessions

DATABASE = SQLite3::Database.new("./database/convention_manager.db")

req_rel("database")
req_rel("models")
req_rel("helpers")

helpers Dropdown, StringToClass, FormCreate, GetMap, ViewFormat, RedirectHelper, EditFormat

# ==============
# Before Filters
# ==============

['/view', '/search', '/create', '/delete'].each do |path|
  before path do
    if params[:type] == nil
      redirect to("/?type=none")
    end
  end
end

['/view', "/edit"].each do |path|
  before path do
    @results = to_class(params[:type]).search_for("id", params[:id])
  end
end

before "/new" do 
  if params[:correct] == "no"
    request.path_info = "/create"
  end
end

# ===============
# Router Handlers
# ===============

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
  if params[:type] == "person"
    params["password"] = params["password"].hash
  end
  binding.pry
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
  @obj = @results[0]
  erb :view
end

get "/edit" do
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
  @results = to_class(params[:type]).all
  erb :delete
end

get "/confirm_delete" do
  @obj = to_class(params[:type]).search_for("id", params[:id])[0]
  erb :confirm_delete
end

get "/confirm_add" do
  @obj = to_class(params[:type]).new(params)
  erb :confirm_add
end

get "/remove" do
  to_class(params[:type]).delete(params[:id])
  redirect to('/')
end

get "/logout" do
  session[:user] = nil
  redirect to("/")
end

get "/login" do
  erb :login
end

get "/user_validation" do
  validator = Person.search_for("username", params[:username])[0]
  binding.pry
  if validator == [] || params[:password].hash != validator.password
    session[:error_message] = "That is not a valid Username/Password pair.  Please try again."
    redirect to("/login")
  else
    session[:user] = validator.username
    redirect to "/"
  end
end

get "/signup" do
  params[:type] = "person"
  @reqs = get_requirements(params[:type])
  erb :signup
end
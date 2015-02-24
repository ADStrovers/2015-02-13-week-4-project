require 'sinatra'
require_relative 'load.rb'

# ==============
# Before Filters
# ==============

before "/new" do 
  unless validate_presence_of(params[:username])
    session[:error_message] = "I'm sorry.  You must enter a username before proceeding."
    redirect to("/signup")
  end
  unless validate_presence_of(params[:password])
    session[:error_message] = "I'm sorry.  You must enter a password before proceeding."
    redirect to("/signup")
  end
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
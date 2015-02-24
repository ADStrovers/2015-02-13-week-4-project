require 'sinatra'
require 'sqlite3'
require 'pry'
require 'rubygems'
require 'active_support/inflector'
require 'geocoder'
require 'sinatra/partial'
require 'bcrypt'

set :partial_template_engine, :erb
enable :sessions

DATABASE = SQLite3::Database.new("./database/convention_manager.db")

Dir['./database/*.rb'].each { |file| require file }
Dir['./models/*.rb'].each { |file| require file }
Dir['./helpers/*.rb'].each { |file| require file }
Dir['./controllers/*.rb'].each { |file| require file }

helpers StringToClass, FormCreate, GetMap, ViewFormat, RedirectHelper, EditFormat,
        Validators
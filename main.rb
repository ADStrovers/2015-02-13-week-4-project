require 'sinatra'
require 'sqlite3'
require 'pry'
require 'rubygems'
require 'active_support/inflector'
require 'geocoder'
require 'sinatra/partial'
require 'bcrypt'

set :bind, '0.0.0.0'

set :partial_template_engine, :erb
enable :sessions

DATABASE = SQLite3::Database.new("./convention_manager.db")

Dir['./database/*.rb'].each { |file| require file }
Dir['./models/*.rb'].each { |file| require file }
Dir['./helpers/*.rb'].each { |file| require file }
Dir['./controllers/*.rb'].each { |file| require file }
Dir['./classes/*.rb'].each { |file| require file }

OBJECT_HANDLER = CreatorFactory.new

helpers FormCreate, GetMap, ViewFormat, RedirectHelper, EditFormat,
        Validators
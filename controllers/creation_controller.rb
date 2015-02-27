before "/new/:type" do 
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

get "/create/:type" do
  @reqs = OBJECT_FACTORY.create_new_object(params).requirements
  @convention_list = Convention.all
  @person_list = Person.all
  @panel_list = Panel.all
  erb :"creation/create"
end

get "/new/person" do
  params["password"] = BCrypt::Password.create(params["password"])
  @obj = Person.new(params)
  @obj.insert
  query_string = request.query_string
  redirect to("/user_validation?#{query_string}")
end

post "/new/:type" do
  @obj = OBJECT_FACTORY.create_new_object(params)
  @obj.creator_id = Person.search_for("username", session[:username])[0].id
  @obj.insert
  redirect_assist("view/#{params[:type]}")
end

get "/confirm_add/:type" do
  @obj = OBJECT_FACTORY.create_new_object(params)
  erb :"creation/confirm_add"
end
before "/new" do 
  unless validate_presence_of(params[:username])
    session[:error_message] = "I'm sorry.  You must enter a username before proceeding."
    redirect to("user/signup")
  end
  unless validate_presence_of(params[:password])
    session[:error_message] = "I'm sorry.  You must enter a password before proceeding."
    redirect to("user/signup")
  end
  if params[:correct] == "no"
    request.path_info = "creation/create"
  end
end

get "/creation/create" do
  @reqs = get_requirements(params[:type])
  @convention_list = Convention.all
  @person_list = Person.all
  @panel_list = Panel.all
  erb :"creation/create"
end

get "/new" do
  if params[:type] == "person"
    params["password"] = BCrypt::Password.create(params["password"])
  end
  @obj = to_class(params[:type]).new(params)
  unless params[:type] == "person"
    @obj.creator_id = Person.search_for("username", session[:username])[0].id
  end
  @obj.insert
  if params[:type] == "person"
    query_string = request.query_string
    redirect to("/user_validation?#{query_string}")
  else
    redirect_assist("view")
  end
end

get "/creation/confirm_add" do
  @obj = to_class(params[:type]).new(params)
  erb :"creation/confirm_add"
end
get "/logout" do
  session[:username] = nil
  redirect to("/")
end

get "/login" do
  erb :"user/login"
end

get "/user_validation" do
  validator = Person.search_for("username", params[:username])[0]
  validator.password = BCrypt::Password.new(validator.password)
  if validator == [] || validator.password != params[:password]
    session[:error_message] = "That is not a valid Username/Password pair.  Please try again."
    redirect to("user/login")
  else
    session[:username] = validator.username
    session[:message] = "Welcome #{session[:username]}.  Thank you for coming by."
    redirect to "/"
  end
end

get "/signup" do
  params[:type] = "person"
  @reqs = get_requirements(params[:type])
  erb :"user/signup"
end

get "/attend/:type" do
  query_string = request.query_string
  @person = Person.search_for("username", session[:username])[0]
  @person.send("attend_#{params[:type]}".to_sym, params[:id])
  session[:message] = "You are now attending the #{params[:type].capitalize}.  Thank you!"
  redirect to("/")
end
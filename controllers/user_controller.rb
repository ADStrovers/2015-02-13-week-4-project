get "/logout" do
  session[:username] = nil
  redirect to("/")
end

get "/login" do
  erb :"user/login"
end

get "/user_validation" do
  if Person.validated?(params)
    session[:username] = params["username"]
    session[:message] = "Welcome #{session[:username]}.  Thank you for coming by."
    redirect to "/"
  else
    session[:message] = "That is not a valid Username/Password pair.  Please try again."
    redirect to("/login")
  end
end

get "/signup" do
  params["type"] = "person"
  @reqs = OBJECT_FACTORY.create_new_object(params).requirements
  erb :"user/signup"
end

post "/attend/:type" do
  @person = Person.search_for("username", session[:username])[0]
  success = @person.send("attend_#{params[:type]}".to_sym, params[:id])
  if success
    session[:message] = "You are now attending the #{params[:type].capitalize}.  Thank you!"
  else
    session[:message] = "You are already attending the #{params[:type].capitalize}."
  end
  redirect to("/")
end
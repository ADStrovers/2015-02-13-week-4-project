get "/delete" do
  @results = to_class(params[:type]).all
  erb :delete
end

get "/confirm_delete" do
  @obj = to_class(params[:type]).search_for("id", params[:id])[0]
  erb :confirm_delete
end

get "/remove" do
  to_class(params[:type]).delete(params[:id])
  session[:message] = "You have successfully deleted the #{params[:type].capitalize}"
  redirect to('/')
end
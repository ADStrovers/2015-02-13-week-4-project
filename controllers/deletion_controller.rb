get "/deletion/delete" do
  @results = to_class(params[:type]).all
  erb :"deletion/delete"
end

get "/deletion/confirm_delete" do
  @obj = to_class(params[:type]).search_for("id", params[:id])[0]
  erb :"deletion/confirm_delete"
end

get "/remove" do
  to_class(params[:type]).delete(params[:id])
  session[:message] = "You have successfully deleted the #{params[:type].capitalize}"
  redirect to('/')
end
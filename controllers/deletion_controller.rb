get "/delete/:type" do
  @results = to_class(params[:type]).all
  erb :"deletion/delete"
end

get "/confirm_delete/:type" do
  @obj = to_class(params[:type]).search_for("id", params[:id])[0]
  erb :"deletion/confirm_delete"
end

get "/remove/:type" do
  to_class(params[:type]).delete(params[:id])
  session[:message] = "You have successfully deleted the #{params[:type].capitalize}"
  redirect to('/')
end
get "/delete/:type" do
  @results = OBJECT_HANDLER.fetch_all(params)
  erb :"deletion/delete"
end

get "/confirm_delete/:type" do
  @obj = OBJECT_HANDLER.fetch_object_by_id(params)
  erb :"deletion/confirm_delete"
end

post "/remove/:type" do
  OBJECT_HANDLER.delete_by_id(params)
  session[:message] = "You have successfully deleted the #{params[:type].capitalize}"
  redirect to('/')
end
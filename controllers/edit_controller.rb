get "/edit/:type" do
  erb :"edit/edit"
end

post "/save/:type" do
  @obj = OBJECT_HANDLER.create_new_object(params)
  @obj.save
  query_string = request.query_string
  redirect to("view/#{params[:type]}?#{query_string}")
end
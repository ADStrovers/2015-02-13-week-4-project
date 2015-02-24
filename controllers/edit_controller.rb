get "/edit/:type" do
  @obj = @results[0]
  erb :"edit/edit"
end

get "/save/:type" do
  @obj = to_class(params[:type]).new(params)
  @obj.save
  query_string = request.query_string
  redirect to("view/#{params[:type]}?#{query_string}")
end
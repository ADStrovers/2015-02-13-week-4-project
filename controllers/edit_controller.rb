get "/edit/edit" do
  @obj = @results[0]
  erb :"edit/edit"
end

get "/save" do
  @obj = to_class(params[:type]).new(params)
  @obj.save
  query_string = request.query_string
  redirect to("view/view?#{query_string}")
end
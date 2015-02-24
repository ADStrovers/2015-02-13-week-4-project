get "/edit" do
  @obj = @results[0]
  erb :edit
end

get "/save" do
  @obj = to_class(params[:type]).new(params)
  @obj.save
  query_string = request.query_string
  redirect to("/view?#{query_string}")
end
get "/search" do
  unless params[:id] == nil
    redirect_assist("view")
  end
  @reqs = get_requirements_with_id(params[:type])
  erb :search
end

get "/search_results" do
  if params[:field].nil? || params[:value].nil?
    redirect to("/search?#{params[:type]}")
  end
  @results = to_class(params[:type]).search_for("#{params[:field]}", params[:value])
  erb :search_results
end

get "/view" do
  @obj = @results[0]
  if params[:type] == "convention"
    @panels = Panel.search_for("convention_id", params[:id])
  end
  erb :view
end
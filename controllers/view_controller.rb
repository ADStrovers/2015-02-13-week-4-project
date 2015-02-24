get "/search/:type" do
  unless params[:id] == nil
    redirect_assist("view/#{params[type]}")
  end
  @reqs = get_requirements_with_id(params[:type])
  erb :"view/search"
end

get "/search_results/:type" do
  if params[:field].nil? || params[:value].nil?
    redirect to("/search/#{params[:type]}")
  end
  @results = to_class(params[:type]).search_for("#{params[:field]}", params[:value])
  erb :"view/search_results"
end

get "/view/:type" do
  @obj = @results[0]
  if params[:type] == "convention"
    @panels = Panel.search_for("convention_id", params[:id])
  end
  erb :"view/view"
end
get "/search/:type" do
  unless params[:id] == nil
    redirect_assist("view/#{params[type]}")
  end
  @reqs = OBJECT_FACTORY.fetch_object_by_id(params).requirements_with_id
  erb :"view/search"
end

get "/search_results/:type" do
  if params[:field].nil? || params[:value].nil?
    redirect to("/search/#{params[:type]}")
  end
  @results = OBJECT_FACTORY.fetch_object_by_field(params)
  erb :"view/search_results"
end

get "/view/:type" do
  if params[:type] == "convention"
    @panels = Panel.search_for("convention_id", params[:id])
  end
  erb :"view/view"
end
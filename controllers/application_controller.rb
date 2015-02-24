['/view/:type', '/search/:type', '/create/:type', '/delete/:type'].each do |path|
  before path do
    if params[:type] == nil
      redirect to("/?type=none")
    end
  end
end

['/view/:type', 'edit/:type'].each do |path|
  before path do
    @results = to_class(params[:type]).search_for("id", params[:id])
  end
end
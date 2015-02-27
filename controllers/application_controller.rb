['/view/:type', '/search/:type', '/create/:type', '/delete/:type'].each do |path|
  before path do
    unless ["person", "convention", "panel"].include? params[:type] 
      redirect to("/")
    end
  end
end

['/view/:type', 'edit/:type'].each do |path|
  before path do
    @obj = OBJECT_HANDLER.fetch_object_by_id(params)[0]
  end
end
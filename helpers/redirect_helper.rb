module RedirectHelper
  def redirect_assist(path)
    redirect to("/#{path}?type=#{params[:type]}&id=#{@obj.id}")
  end
end
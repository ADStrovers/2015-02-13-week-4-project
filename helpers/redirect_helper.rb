module RedirectHelper
  def redirect_assist(path)
    redirect to("/#{path}?id=#{@obj.id}")
  end
end
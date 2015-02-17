module GetMap
  def get_map(obj)
    map = "<img src=\"https://maps.googleapis.com/maps/api/staticmap?size=360x360&zoom=15&center=#{obj.address}&markers=#{obj.address}\">"
  end
end
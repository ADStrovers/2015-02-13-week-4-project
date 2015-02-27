module GetMap
  
  # Public: #get_map
  # Goes out to Google's Static Map API and pulls up a map based on the object's address.
  #
  # Parameters:
  # obj - Object you wish to get a map for.
  #
  # Returns:
  # A string with the HTML code for the map.
  #
  # State Changes:
  # None
  
  def get_map(obj)
    map = "<img src=\"https://maps.googleapis.com/maps/api/staticmap?size=320x320&zoom=15&center=#{obj.address}&markers=#{obj.address}\">"
  end
  
end
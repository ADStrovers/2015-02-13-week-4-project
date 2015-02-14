class Convention
  include DatabaseMethods
  
  def initialize(options)
    @name = options["name"]
    @loc_lat = options["loc_lat"]
    @loc_lon = options["loc_lon"]
  end
  
end
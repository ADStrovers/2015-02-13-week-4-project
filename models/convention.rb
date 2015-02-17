class Convention
  include DatabaseMethods
  include 
  
  def initialize(options)
    @name = options["name"]
    @address = options["address"]
    @latitude = options["loc_lat"]
    @longitude = options["loc_lon"]
  end
  
end
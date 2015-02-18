class Convention
  include DatabaseMethods
  attr_accessor :name, :address, :latitude, :longitude, :id
  
  def initialize(options)
    @id = options["id"]
    @name = options["name"]
    @address = options["address"]
    get_lat_and_long(@address) unless @address == nil
  end
  
  def get_lat_and_long(address)
    info = Geocoder.search("#{address}")
    @latitude = info[0].latitude
    @longitude = info[0].longitude
  end
  
end
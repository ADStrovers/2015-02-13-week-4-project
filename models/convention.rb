class Convention
  include DatabaseMethods
  attr_accessor :name, :address, :latitude, :longitude, :id
  
  def initialize(options)
    @name = options["name"]
    @address = options["address"]
  end
  
  def get_lat_and_long(address)
    info = Geocoder.search("#{address}")
    binding.pry
    @latitude = info[0].latitude
    @longitude = info[0].longitude
  end
  
end
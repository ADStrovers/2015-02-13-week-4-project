class Convention
  include DatabaseMethods
  attr_accessor :name, :address, :latitude, :longitude, :id, :creator_id
  
  def initialize(options)
    @id = options["id"]
    @name = options["name"]
    @address = options["address"]
    get_lat_and_long(@address) unless @address == nil
  end
  
  # Public: #get_lat_and_long
  # Takes the given address and finds it's latitude and longitude using Geocoder
  #
  # Parameters:
  # address - String: Address of the given location.
  #
  # Returns:
  # @longitude
  #
  # State Changes:
  # @latitude, @longitude
  
  def get_lat_and_long(address)
    info = Geocoder.search("#{address}")
    @latitude = info[0].latitude
    @longitude = info[0].longitude
    
    return @latitude, @longitude
  end
  
end
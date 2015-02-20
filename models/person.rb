class Person
  include DatabaseMethods
  attr_accessor :name, :username, :password, :id, :creator_id
  
  def initialize(options)
    @id = options["id"]
    @username = options["username"]
    @name = options["name"]
    @password = options["password"]
  end
  
end
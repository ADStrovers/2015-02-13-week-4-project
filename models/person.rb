class Person
  include DatabaseMethods
  attr_accessor :name, :username, :password, :id
  
  def initialize(options)
    @id = options["id"]
    @username = options["username"]
    @name = options["name"]
    @password = options["password"]
  end
  
end
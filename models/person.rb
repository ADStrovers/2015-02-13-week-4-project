class Person
  include DatabaseMethods
  attr_accessor :name, :username, :password, :id, :creator_id
  
  def initialize(options)
    @id = options["id"]
    @username = options["username"]
    @name = options["name"]
    @password = options["password"]
  end
  
  def attend_convention(id)
    DATABASE.execute("INSERT INTO conventions_people (convention_id, person_id) VALUES (#{id}, #{self.id})")
  end
  
  def attend_panel(id)
    DATABASE.execute("INSERT INTO panels_people (panel_id, person_id) VALUES (#{id}, #{self.id})")
  end
  
  # Public: #get_username
  # Returns the username of the Person ID inputted
  #
  # Parameters:
  # id - Integer: equal to the primary key of the row you want the username from.
  #
  # Returns:
  # username - String
  #
  # State Changes:
  # None
  
  def self.get_username(id)
    username = DATABASE.execute("SELECT username FROM people WHERE id = #{id}")
  end
  
end
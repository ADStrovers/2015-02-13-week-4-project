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
  
end
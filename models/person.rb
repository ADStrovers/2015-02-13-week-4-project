class Person
  include DatabaseMethods
  
  def initialize(options)
    @id = options["id"]
    @name = options["name"]
    @convention_id = options["convention_id"]
    @panel_id = options["panel_id"]
  end
  
end
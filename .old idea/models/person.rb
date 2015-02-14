class Person
  include DatabaseMethods
  
  def initialize(options)
    @name = options["name"]
    @convention_id = options["convention_id"]
    @panel_id = options["panel_id"]
  end
  
end
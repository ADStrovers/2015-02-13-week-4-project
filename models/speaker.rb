class Speaker
  include DatabaseMethods
  
  def initialize
    @person_id = options["person_id"]
    @panel_id = options["panel_id"]
    @alias = options["alias"]
  end
  
end
class Panel
  include DatabaseMethods
  
  def initialize(options)
    @id = options["id"]
    @name = options["name"]
    @speaker_id = options["speaker_id"]
    @convention_id = options["convention_id"]
    @person_id = options["person_id"]
  end
  
end
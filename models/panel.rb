class Panel
  include DatabaseMethods
  attr_accessor :id, :name, :creator_id, :convention_id
  
  def initialize(options)
    @id = options["id"]
    @name = options["name"]
    @creator_id = options["speaker_id"]
    @convention_id = options["convention_id"]
  end
  
end
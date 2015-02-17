module RequireHandler
  def req_rel(path)
    models = Dir["./#{path}/*.rb"]
    models.each do |file|
      require_relative file
    end
  end
end
class CreatorFactory
  
  def create_new_object(options)
    options["type"].classify.constantize.new(options)
  end
  
  def fetch_object_by_id(options)
    options["type"].classify.constantize.search_for("id", options["id"])
  end
  
  def fetch_object_by_field(options)
    options["type"].classify.constantize.search_for(options["field"], options["value"])
  end
  
  def delete_by_id(options)
    options["type"].classify.constantize.delete("id", options["id"])
  end
  
  def fetch_all(options)
    options["type"].classify.constantize.all
  end
  
end
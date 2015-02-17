module StringToClass
  
  def get_requirements(name_string)
    to_class(name_string).new({}).requirements
  end
  
  def to_class(name)
    name.classify.constantize
  end
  
end
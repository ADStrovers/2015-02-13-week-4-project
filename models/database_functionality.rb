module DatabaseInstanceMethods
  
  module DatabaseClassMethods
    
  end
  
  def self.included(base)
    base.extend(DatabaseClassMethods)
  end
  
end
module DatabaseMethods
  
  module DatabaseClassMethods
    
    def all
      DATABASE.execute("SELECT * FROM #{self.class.to_s.pluralize}")
    end
    
    def search_for(field, value)
      results_as_objects = []
      
      if value.is_a? Integer
        results = DATABASE.execute("SELECT * FROM #{self.class.to_s.pluralize} WHERE #{field} = #{value}")
      else
        results = DATABASE.execute("SELECT * FROM #{self.class.to_s.pluralize} WHERE #{field} = '#{value}'")
      end
      
      results.each do |item|
        results_as_objects << self.new(item) if item != nil
      end
      
      results_as_objects
  end
  
  def self.included(base)
    base.extend(DatabaseClassMethods)
  end
  
  def insert
    
  end
  
  def save
    
  end
  
end
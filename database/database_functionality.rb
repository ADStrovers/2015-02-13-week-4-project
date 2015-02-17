module DatabaseMethods
  
  module DatabaseClassMethods
    
    def requirements
      attributes = []
      instances_variables.each do |var|
        unless var == :@id
          attributes << var.to_s.delete('@')
        end
      end
      
      attributes
    end
    
    # Public: #delete
    # Deletes the given id from the class's database
    #
    # Parameters:
    # id - Integer: Primary ID of the row to be deleted.
    #
    # Returns:
    # Empry Array
    #
    # State Changes:
    # None
    
    def delete
      DATABASE.execute("DELETE FROM #{self.to_s.pluralize} WHERE id = #{id}")
    end
    
    # Public: #all
    # Return all rows that belong to the class' database as objects
    #
    # Returns:
    # An array of objects.
    #
    # State Changes:
    # None
    
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
    
  end
  
  def self.included(base)
    base.extend(DatabaseClassMethods)
  end
  
  def insert
    attributes = []
    values = []
    
    instance_variables.each do |x|
      unless x == :@id
        attributes << x.to_s.delete('@')
      end
    end
    
    columns = attributes.join(", ")
    attributes.each do |x| 
      if self.send(x).is_a? Integer
        values << self.send(x)
      else
        values << "'#{self.send(x)}'"
      end 
    end
    
    DATABASE.execute("INSERT INTO #{self.class.to_s.pluralize} (#{columns}) VALUES (#{values.join(', ')})")
    @id = DATABASE.last_insert_row_id
  end
  
  def save
    attributes = []
    instance_variables.each do |i|
      attributes << i.to_s.delete("@")
    end
  
    query_components_array = []
  
    attributes.each do |a|
      value = self.send(a)
    
      if value.is_a?(Integer)
        query_components_array << "#{a} = #{value}"
      else
        query_components_array << "#{a} = '#{value}'"
      end
    end
  
    query_string = query_components_array.join(", ")
  
    DATABASE.execute("UPDATE #{self.class.to_s.pluralize} SET #{query_string} WHERE id = #{id}")
  end
  
end
# Module: DatabaseMethods
#
# Assists models with database queries by giving them access to new instance methods
#
# Public Methods:
# #requirements
# #requirements_with_id
# #insert
# #save

module DatabaseMethods
  
  # Module: DatabaseClassMethods
  #
  # Assists models with database queries by giving them access to new class methods
  #
  # Public Methods:
  # #delete
  # #all
  # #search_for
  
  module DatabaseClassMethods
    
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
    
    def delete(id)
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
      results = []
      items = DATABASE.execute("SELECT * FROM #{self.to_s.pluralize}")
      items.each do |item|
        results << self.new(item)
      end
      
      results
    end
    
    # Public: #search_for
    # Return all rows that match the field and value passed in from the class' database as objects
    #
    # Parameters:
    # field - String: name of the column to check
    # value - String: the value to search within the given field for
    #
    # Returns:
    # An array of objects.
    #
    # State Changes:
    # None
    
    def search_for(field, value)
      results_as_objects = []
      
      if value.is_a? Integer
        results = DATABASE.execute("SELECT * FROM #{self.to_s.pluralize} WHERE #{field} = #{value}")
      else
        results = DATABASE.execute("SELECT * FROM #{self.to_s.pluralize} WHERE #{field} LIKE '#{value + '%'}'")
      end
      
      results.each do |item|
        results_as_objects << self.new(item) if item != nil
      end
      
      results_as_objects
    end
    
  end
  
  # Private (special): #self.included
  # Autorun when included into a class and it autoextended the class methods within this module.
  #
  # Returns:
  # Boolean
  #
  # State Changes:
  # None
  
  def self.included(base)
    base.extend(DatabaseClassMethods)
  end
  
  # Public: #requirements_with_id
  # Returns all instance_variables of the object including "id"
  #
  # Returns:
  # Array of all instance variables
  #
  # State Changes:
  # None
  
  def requirements_with_id
    attributes = []
    instance_variables.each do |var|
      attributes << var.to_s.delete('@')
    end
    
    attributes
  end
  
  # Public: #requirements
  # Returns all instance_variables of the object without id
  #
  # Returns:
  # Array of all instance variables except "id"
  #
  # State Changes:
  # None
  
  def requirements
    attributes = []
    instance_variables.each do |var|
      unless var == :@id
        attributes << var.to_s.delete('@')
      end
    end
    
    attributes
  end
  
  # Public: #insert
  # Inserts the given object into the model's database and returns the "id" of the newly created object row.
  #
  # Returns:
  # @id of the object.
  #
  # State Changes:
  # None
  
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
  
  # Public: #save
  # Saves the object into the models database.
  # 
  # Returns:
  # An empty array.
  #
  # State Changes:
  # None
  
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
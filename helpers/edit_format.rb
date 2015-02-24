module EditFormat
  
  # Public: #create_form
  # Helps direct a erb form creation to the proper partials based on field name.
  #
  # Parameters:
  # requirements - Array of field names that need to be addressed.
  #
  # Returns:
  # Array full of HTML to create the input for a form
  #
  # State Changes:
  # None
  
  def edit_output(obj)
    string_array = ["<input type=\"hidden\" name=\"id\" value=\"#{obj.id}\">"]
    obj.instance_variables.each do |var|
      unless var == :@id
        var = var.to_s.delete("@")
        string_array << "<div><label for=\"#{var}\"}>#{var.capitalize}</label>"
        string_array << "<input type=\"text\" name=\"#{var}\" value=\"#{obj.send(var)}\"></div>"
      end
    end
    string_array << get_map(obj)
    
    string_array
  end
  
end
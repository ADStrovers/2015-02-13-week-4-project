module ViewFormat
  
  # Public: #view_output
  # Returns HTML for automating forms.
  #
  # Parameters:
  # obj - Object
  #
  # Returns:
  # An array of html elements
  #
  # State Changes:
  # None
  
  def view_output(obj)
    string_array = ["<input type=\"hidden\" name=\"id\" value=\"#{obj.id}\">"]
    obj.instance_variables.each do |var|
      unless var == :@id
        var = var.to_s.delete("@")
        string_array << "<div><label for=\"#{var}\"}>#{var.capitalize}</label>"
        string_array << "<input type=\"text\" name=\"#{var}\" value=\"#{obj.send(var)}\" readonly></div>"
      end
    end
    if params[:type] == "convention"
      string_array << get_map(obj)
    end
    
    string_array
  end
  
end
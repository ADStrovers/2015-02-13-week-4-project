module ViewFormat
  
  def view_output(obj)
    string_array = []
    obj.instance_variables.each do |var|
      unless var == :@id
        var = var.to_s.delete("@")
        string_array << "<div><label>#{var.capitalize}</label>"
        string_array << "<input type=\"text\" disabled=\"true\" value=\"#{obj.send(var)}\"></div>"
      end
    end
    string_array << get_map(obj)
    
    string_array
  end
  
end
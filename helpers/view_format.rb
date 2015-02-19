module ViewFormat
  
  def view_output(obj)
    string_array = ["<input type=\"hidden\" name=\"id\" value=\"#{params[:id]}\">"]
    string_array << partial(:'/partials/hidden_type', :layout => false, :locals => { :type => params[:type] })
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
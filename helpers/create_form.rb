module FormCreate
  def create_form(requirements)
    string_array = ["<input type=\"hidden\" name=\"type\" value=\"#{params[:type]}\""]
    requirements.each do |req|
      case req
      when "name", "address"
        string_array << "<div><label for=\"#{req}\">#{req.capitalize}</label>"
        string_array << "<input type=\"text\" name=\"#{req}\"></div>"
      when "panel_id"
        string_array << "<div><label for=\"#{req}\">#{req.capitalize.delete("_id")}</label>"
        string_array << "<select>"
        @panel_list.each do |item|
          string_array << "<option value=\"#{item.id}\">#{item.name}</option>"
        end
        string_array << "</select></div>"
      when "person_id"
        string_array << "<div><label for=\"#{req}\">#{req.capitalize.delete("_id")}</label>"
        string_array << "<select>"
        @person_list.each do |item|
          string_array << "<option value=\"#{item.id}\">#{item.name}</option>"
        end
        string_array << "</select></div>"
      when "convention_id"
        string_array << "<div><label for=\"#{req}\">#{req.capitalize.delete("_id")}</label>"
        string_array << "<select>"
        @convention_list.each do |item|
          string_array << "<option value=\"#{item.id}\">#{item.name}</option>"
        end
        string_array << "</select></div>"
      end
    end
    string_array << "<div><button type=\"submit\">Create New #{params[:type].capitalize}</button></div>"
    
    string_array
  end
end
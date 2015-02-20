module FormCreate
  
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
  
  def create_form(requirements)
    string_array = []
    string_array << partial(:'/partials/hidden_type', :locals => { :type => params[:type] })
    requirements.each do |req|
      case req
      when "name", "address", "password", "username"
        string_array << partial(:'/partials/textbox', :layout => false, :locals => { :req => req })
      when "panel_id"
        string_array << partial(:'/partials/panel_id', :layout => false, :locals => { :req => req })
      when "person_id"
        string_array << partial(:'/partials/person_id', :layout => false, :locals => { :req => req })
      when "convention_id"
        string_array << partial(:'/partials/convention_id', :layout => false, :locals => { :req => req })
      end
    end
    string_array << "<div><button type=\"submit\">Create New #{params[:type].capitalize}</button></div>"
    
    string_array
  end
end
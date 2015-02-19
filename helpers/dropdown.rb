module Dropdown
  def dropdown(menu)
    menu = ["<li>#{menu.capitalize}",
            "<ul class=\"dropdown_menu\">",
            "<li><a href=\"/#{menu}?type=convention\">Convention</a></li>", 
            "<li><a href=\"/#{menu}?type=panel\">Panel</a></li>", 
            "</ul></li>"]
  end
end
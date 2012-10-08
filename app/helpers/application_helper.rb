module ApplicationHelper
  def footer_message
    capture_haml do
      haml_tag :p, "&copy; #{DateTime.now.year} <a href=\"http://caleb.io\" target=\"_blank\">Caleb Mingle</a>. All Rights Reserved.".html_safe
    end
  end
end

module ApplicationHelper
  def footer_message
    capture_haml do
      haml_tag :p, "&copy; #{DateTime.now.year} <a href=\"http://caleb.io\" target=\"_blank\">Caleb Mingle</a>. All Rights Reserved.".html_safe
    end
  end

  #TODO: clean this up below, there is duplication between error handlers.
  def devise_error_messages
    return "" if resource.errors.empty? && flash[:alert].nil? && flash[:notice].nil?

    capture_haml do

      if flash[:alert].present?
        haml_tag :div, flash[:alert], :class => 'alert alert-error'
      end

      if flash[:notice].present?
        haml_tag :div, flash[:notice], :class => 'alert alert-notice'
      end

      resource.errors.full_messages.each do |error|
        haml_tag :div, error, :class => 'alert alert-error'
      end
    end
  end

  def display_errors(errors)
    capture_haml do
      errors.each do |error|
        haml_tag :div, error, :class => 'alert alert-error'
      end
    end
  end
end

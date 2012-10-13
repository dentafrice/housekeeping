module Admin::UsersHelper
  def tabs
    capture_haml do
      haml_tag :ul, :class => 'nav nav-tabs' do
        haml_tag :li, :class => ((%w{index edit update}.include?(params[:action])) ? 'active' : '') do
          haml_tag :a, 'Manage' ,{:href => admin_users_path}
        end

        haml_tag :li, :class => ((%w{new create}.include?(params[:action])) ? 'active' : '')  do
          haml_tag :a, 'Create', {:href => new_admin_user_path}
        end
      end
    end
  end
end

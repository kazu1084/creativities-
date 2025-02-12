class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up ,keys:[:name])
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(Client)
    client_mypage_path(current_client.id)
    else
    contractor_mypage_path(current_contractor.id)
    end
  end
end

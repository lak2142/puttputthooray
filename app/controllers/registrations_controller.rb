class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters
  def new
    @user_type = params[:type]
    super
  end

  def create
    @user_type = params[:user][:user_type]
    super
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :user_type
  end

end


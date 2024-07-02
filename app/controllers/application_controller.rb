class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken

  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format.json? }

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :user_active!, unless: :devise_controller?
  before_action :authenticate_admin!, unless: :devise_controller?

  private

  def user_active!
    render json: { error: 'You are suspended, check with an admin.' }, status: :unauthorized unless current_user&.active?
  end

  def authenticate_admin!
    render json: { error: 'Access denied' }, status: :unauthorized unless current_user&.admin?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation, :role])
  end
end

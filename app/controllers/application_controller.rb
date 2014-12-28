class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
  def autenticate
    unless current_user
      redirect_to sign_in_path, notice: "You should to login to access chat"
    end
  end
end

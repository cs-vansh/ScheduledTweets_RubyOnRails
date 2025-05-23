class ApplicationController < ActionController::Base
  attr_reader :user

  before_action :set_current_user
  def set_current_user
    if session[:user_id]
      # @user = User.find_by(id: session[:user_id])
      Current.user = User.find_by(id: session[:user_id])
    else
      # @user = nil
      Current.user = nil
    end
  end

  # ! is a naming convention that signals the method performs a "dangerous" or important action—something that changes state, raises an error, or is more strict than a non-bang version.
  def require_user_logged_in!
    redirect_to sign_in_path, alert: "You must be signed in to do that." if Current.user.nil?
  end


  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
end

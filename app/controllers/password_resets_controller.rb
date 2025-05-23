class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user.present?
      # Send email
      # Used 'rails g mailer Password reset' to generate the mailer called PasswordMailer with reset functionality

      # deliver_later will send the email in the background (background job). Use is: to process request immediately even when sending the mail takes 1-2 seconds
      # deliver_now is the immediate one, will send mail, then finish processing the request
      PasswordMailer.with(user: @user).reset.deliver_now
    end

    redirect_to root_path, notice: "If an account with that email was found, we have sent a link to reset your password."
  end

  def edit
    # find_signed() gets stuck but find_signed!() will throw an error if not found
    @user = User.find_signed!(params[:token], purpose: "password_reset")
  rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to password_reset_path, alert: "Your token has expired. Please try again."
  end

  def update
    @user = User.find_signed!(params[:token], purpose: "password_reset")
    if @user.update(password_params)
      redirect_to sign_in_path, notice: "Your password was reset successfully. Please sign in."
    else
      render :edit
    end
  end

  private
  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end

class PasswordMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.password_mailer.reset.subject
  #
  def reset
    # signed_id generates a secure token from the globalId(which is a unique way to identify any object)
    # lets say some user has global id 4(actually its some path/4) then signed_id gives an id that server can identify. Parameters can also be passed to signed_id, which will generate a different id.
    # purpose: "password_reset" will help us identify the purpose of the token, so token taken from somewhere else is not used for resetting password
    # expires_in: 15.minutes will expire the token in 15 minutes
    @token=params[:user].signed_id(purpose: "password_reset", expires_in: 15.minutes)

    @greeting = "Hi"

    mail to: params[:user].email
  end
end

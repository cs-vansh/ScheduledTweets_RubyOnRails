class OmniauthCallbacksController < ApplicationController
  def twitter
    Rails.logger.info auth

    # First check if this Twitter account exists for any other user
    existing_account = TwitterAccount.find_by(username: auth.info.nickname)
    if existing_account && existing_account.user_id != Current.user.id
      redirect_to twitter_accounts_path, alert: "This Twitter account is already linked to another user."
      return
    end

    # If we get here, either the account doesn't exist or it belongs to the current user
    twitter_account = Current.user.twitter_accounts.where(username: auth.info.nickname).first_or_initialize
    twitter_account.update(
      name: auth.info.name,
      # username: auth.info.nickname,
      image: auth.info.image,
      token: auth.credentials.token,
      secret: auth.credentials.secret,
    )

    redirect_to twitter_accounts_path, notice: "Successfully connected your account!!"
  end

  def auth
    request.env["omniauth.auth"]
  end
end

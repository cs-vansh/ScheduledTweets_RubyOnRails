class TwitterAccount < ApplicationRecord
  # dependent: :destroy basically deletes all tweets when a twitter account associated with it is removed/deleted
  has_many :tweets, dependent: :destroy
  belongs_to :user

  # We can link multiple twitter accounts to a single account, but a single twitter account shouldn't be linked multiple times.
  validates :username, uniqueness: true

=begin
  # using twitter gem -> not compatible with X's v2 APIs
  def client
    Twitter::REST::Client.new do |config|
      # twitter's dev api's
      config.consumer_key = Rails.application.credentials.dig(:twitter, :api_key)
      config.consumer_secret = Rails.application.credentials.dig(:twitter, :api_secret)

      # from DB (twitter_accounts has columns called token & secret. Rails automatically creates methods to get values from column directly)
      config.access_token = token
      config.access_token_secret = secret
    end
  end
=end

  def client
    # Force reload of X gem and create new client
    require "x"

    x_credentials = {
      api_key:             Rails.application.credentials.dig(:twitter, :api_key).to_s,
      api_key_secret:      Rails.application.credentials.dig(:twitter, :api_secret).to_s,
      access_token:        token.to_s,
      access_token_secret: secret.to_s,
      base_url:           "https://api.twitter.com"
    }

    # Explicitly use X::Client to avoid namespace conflict
    @x_client = X::Client.new(**x_credentials)
  end
end

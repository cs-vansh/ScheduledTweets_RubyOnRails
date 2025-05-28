class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :twitter_account

  validates :body, length: { minimum: 1, maximum: 280 }
  validates :publish_at, presence: true

  after_initialize do
    # if there is a publish_at value, good. If not, publish at 24 hours from now
    # default date shown will also be +1 hour from now.
    self.publish_at ||= 1.hours.from_now
  end

  after_save_commit do
    if publish_at_previously_changed?
      TweetJob.set(wait_until: self.publish_at).perform_later(self)
    end
  end

  # if adding ? means we are returning true or false from that method
  def published?
    # returns true if tweet_id is not nil
    tweet_id?
  end

  def publish_to_twitter!
    begin
      response = twitter_account.client.post("2/tweets", { text: body }.to_json)
      update(tweet_id: response["data"]["id"])
    rescue => e
      Rails.logger.error "Failed to publish tweet: #{e.message}"
      raise e
    end
  end
end
=begin
  # using twitter gem -> not compatible with X's v2 APIs
  def publish_to_twitter!
    # calling client method on twitter_account association (defined in twitter_account.rb)
    # tweet is a tweet object that the Twitter Gem creates when getting data back in JSON from the Twitter API
    tweet = twitter_account.client.update(body)

    # update and store the id of the posted tweet
    update(tweet_id: tweet.id)
  end
=end

=begin
def publish_to_twitter!
  # Post tweet using X gem's client
  # response = twitter_account.client.post("tweets", { text: body }.to_json)

  # Post tweet using v1.1 API endpoint
  # response = twitter_account.client.post("statuses/update.json", { status: body }.to_json)
  # response = @x_client.post("tweets", status: body)
    # response = twitter_account.client.post("statuses/update.json", status: body)

    # Post tweet using v2 API endpoint.
    # Using x gem's client to post tweet
    response = twitter_account.client.post("2/tweets", { text: body })


    # Update and store the id of the posted tweet
    update(tweet_id: response["data"]["id"])

    # update(tweet_id: response["id"])
  end
end
=end

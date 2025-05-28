class TweetJob < ApplicationJob
  queue_as :default

  # Retry failed jobs up to 3 times with exponential backoff
  retry_on StandardError, wait: :exponentially_longer, attempts: 3

  # Always better to not cancel the jobs, they should be created, and should be smart enough to know when to run and when not to.
  def perform(tweet)
    Rails.logger.info "Attempting to publish tweet ##{tweet.id} at #{Time.current}"
    begin
      # If tweet is already published, don't do anything
      return if tweet.published?

      # If tweet's scheduled time is in the future, don't publish yet
      # This handles postponed tweets (moved to later time)
      return if tweet.publish_at > Time.current

      # If we get here, it means:
      # 1. Tweet is not published yet
      # 2. Current time is >= scheduled time
      # So we can publish the tweet. This handles preponed tweets (moved to earlier time) because if publish_at was moved earlier, it will be < Time.current and this code will execute
      tweet.publish_to_twitter!
      Rails.logger.info "Successfully published tweet ##{tweet.id}"
    rescue => e
      Rails.logger.error "Failed to publish tweet ##{tweet.id}: #{e.message}"
      Rails.logger.error e.backtrace.join("\n")
      raise e  # Re-raise to mark job as failed
    end
  end
end

class TweetsController < ApplicationController
    before_action :require_user_logged_in!
    # set_tweet checks for if there is tweet content, as well as if we are not editing a published tweet
    before_action :set_tweet, only: [ :edit, :update, :destroy ]

    def index
        @tweets = Current.user.tweets
    end

    def new
      @tweet = Tweet.new
    end

    def create
        @tweet = Current.user.tweets.new(tweet_params)
        if @tweet.save
          redirect_to tweets_path, notice: "Tweet was scheduled successfully"
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @tweet.update(tweet_params)
            redirect_to tweets_path, notice: "Tweet was updated successfully"
        else
            render :edit
        end
    end

    def destroy
        @tweet.destroy
        redirect_to tweets_path, notice: "Tweet was unscheduled"
    end

    private

    def tweet_params
        params.require(:tweet).permit(:twitter_account_id, :body, :publish_at)
    end

    def set_tweet
        @tweet = Current.user.tweets.find_by(id: params[:id])
        if @tweet.nil?
            redirect_to tweets_path, alert: "Tweet not found"
        elsif @tweet.published?
            redirect_to tweets_path, alert: "You cannot edit a published tweet"
        end
    end
end

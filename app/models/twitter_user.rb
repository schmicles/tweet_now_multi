class TwitterUser < ActiveRecord::Base
  has_many :tweets

  def fetch_tweets!(twitter_client)
    self.tweets.destroy_all

    twitter_client.user_timeline(self.username, count: 10).each do |pulled_tweet|
      self.tweets.create(text: pulled_tweet.text)
    end
  end

  def self.post_tweet(text, twitter_client)
    twitter_client.update(text)
  end

  def self.twitter_client(oauth_token, oauth_token_secret)
    twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key        = CONSUMER_KEY
      config.consumer_secret     = CONSUMER_SECRET
      config.access_token        = oauth_token
      config.access_token_secret = oauth_token_secret
    end
    twitter_client
  end

end

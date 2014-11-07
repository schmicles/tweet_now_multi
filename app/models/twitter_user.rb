class TwitterUser < ActiveRecord::Base
  # Remember to create a migration!

  def self.fetch_tweets!
    $client.user_timeline("sptsdt")
  end

  def self.post_tweet!(text)
    $client.update(text)
  end
end

class TwitterUser

  def self.fetch_tweets!
    $client.user_timeline("sptsdt")
  end

  def self.post_tweet!(text)
    $client.update(text)
  end
end

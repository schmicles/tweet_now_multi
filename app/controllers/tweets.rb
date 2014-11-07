post '/tweets' do

  #new_tweet = Tweet.create(text: params[:post][:text], twitter_user_id: 1)
  # @user = TwitterUser.find_by_username(params[$client])
  # @user.post_tweet(params[:post][:text])
  # @tweets = @user.fetch_tweets

  TwitterUser.post_tweet!(params[:post][:text])
  @tweets = TwitterUser.fetch_tweets!
  erb :'tweets/show'
end

get '/tweets' do
  @tweets = TwitterUser.fetch_tweets
  erb :'tweets/show'
end
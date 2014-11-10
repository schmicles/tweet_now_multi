get '/tweets' do
  twitter_client = TwitterUser.twitter_client(session[:oauth_token], session[:oauth_token_secret])
  @tweets = TwitterUser.find(session[:twitter_user_id]).fetch_tweets!(twitter_client)
  erb :'tweets/show', :layout => false
end

post '/tweets' do
  twitter_client = TwitterUser.twitter_client(session[:oauth_token], session[:oauth_token_secret])
  TwitterUser.post_tweet(params[:post][:text], twitter_client)
  @tweets = TwitterUser.find(session[:twitter_user_id]).fetch_tweets!(twitter_client)
  erb :'tweets/show', :layout => false
end

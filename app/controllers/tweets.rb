post '/tweets' do
  TwitterUser.post_tweet!(params[:post][:text])
  @tweets = TwitterUser.fetch_tweets!
  erb :'tweets/show'
end

get '/tweets' do
  @tweets = TwitterUser.fetch_tweets!
  erb :'tweets/show', :layout => false
end
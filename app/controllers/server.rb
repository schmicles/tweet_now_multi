require 'bundler/setup'

enable :sessions

get '/oauth/request_token' do
 consumer = OAuth::Consumer.new CONSUMER_KEY, CONSUMER_SECRET, :site => 'https://api.twitter.com'

 request_token = consumer.get_request_token :oauth_callback => CALLBACK_URL
 session[:request_token] = request_token.token
 session[:request_token_secret] = request_token.secret

 puts "request: #{session[:request_token]}, #{session[:request_token_secret]}"

 redirect request_token.authorize_url
end


get '/oauth/callback' do
 consumer = OAuth::Consumer.new CONSUMER_KEY, CONSUMER_SECRET, :site => 'https://api.twitter.com'

 puts "CALLBACK: request: #{session[:request_token]}, #{session[:request_token_secret]}"

 request_token = OAuth::RequestToken.new consumer, session[:request_token], session[:request_token_secret]
 access_token = request_token.get_access_token :oauth_verifier => params[:oauth_verifier]

 # Twitter.configure do |config|
 #   config.consumer_key = CONSUMER_KEY
 #   config.consumer_secret = CONSUMER_SECRET
 #   config.oauth_token = access_token.token
 #   config.oauth_token_secret = access_token.secret
 # end

 # "[#{Twitter.user.screen_name}] access_token: #{access_token.token}, secret: #{access_token.secret}"



  twitter_client = TwitterUser.twitter_client(access_token.token, access_token.secret)
  username = twitter_client.current_user.screen_name

  twitter_user = TwitterUser.find_or_create_by(username: username)

  session[:oauth_token] = access_token.token
  session[:oauth_token_secret] = access_token.secret
  session[:twitter_user_id] = twitter_user.id

  redirect "/users"


end


=begin
user clicks sign in
ur server pings twitter to request for an request token
ur server takes the request token n redirects the browser to twitter
user authorizes and twitter replies ur server
ur server will ask twitter for the user's access tokens
ur server stores the user's access token
ur server redirects user's browser wherever


when user likes an item, tweet their twitter using their access token
=end

get '/' do
  # Look in app/views/index.erb
  # @tweets = TwitterUser.fetch_tweets!
  erb :'/tweets/new'
end

# get '/:username' do

#   @user = TwitterUser.find_by_or_create(params[:username])
#   @user.fetch_tweets
#   # if @user.tweets.empty?
#   #   # User#fetch_tweets! should make an API call
#   #   # and populate the tweets table
#   #   #
#   #   # Future requests should read from the tweets table
#   #   # instead of making an API call
#   #   @user.fetch_tweets!
#   # end
#   @tweets = @user.tweets.limit(10)
#   erb :index
# end
get '/users' do
  erb :'users/show'
end

post '/login' do
  if params[:submit] == "login"
    redirect "/oauth/request_token"
  end
end

delete '/logout' do
  session[:twitter_user_id] = nil
  redirect "/"
end

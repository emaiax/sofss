configure do
  enable :sessions
end

use OmniAuth::Builder do
  provider :facebook, '<api key>', '<api secret>'
end

helpers do
  def current_user
    session[:current_user]
  end
end
  
get "/" do
  haml :index
end

get '/auth/facebook/callback' do
  session[:current_user] = { :name => request.env['omniauth.auth'][:info][:name] }
  redirect '/'
end

get '/auth/logout' do
  session.delete(:current_user)
  redirect '/'
end

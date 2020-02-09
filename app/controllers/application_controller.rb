require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions 
    set :session_secret, "my_plant_mom_app"
  end

  get "/" do
    erb :welcome
  end
  
  helpers do 
    
    def logged_in? 
      !!current_user
    end
    
    def current_user 
      # @current_user ||= User.find_by(id: session[:user_id])
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
    
    # def authorized_to_edit?(plant_entry)
    #   plant_entry.user == current_user
    # end
    
    def login(username, password)
    user = User.find_by(:username => username) 
    if user && user.authenticate(password)
      session[:user_id] = user.id
    else
      redirect "/users/login"
    end
  end
   
   def logout!
    session.clear
   end
  end

end

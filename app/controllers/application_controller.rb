require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions 
    set :session_secret, "my_plant_mom_app"
  end

  get "/" do
    if logged_in?
      redirect "/users/#{current_user.id}"
    else
    erb :welcome
    end
  end
  
  helpers do 
    
    def logged_in? 
      #return true if user is logged in, otherwise false 
      !!current_user
      
    end
    
    def current_user 
      #should return current user, if there is one 
      # @current_user ||= User.find_by(id: session[:user_id])
      @current_user ||= User.find_by(session[:user_id]) if session[:user_id]
    end
    
    def authorized_to_edit?(plant_entry)
      plant_entry.user == current_user
    end
    
  #   def login(username, password)
  #   user = User.find_by(:username => username) 
  #   if user && user.authenticate(password)
  #     session[:user_id] = user.id
  #   else
  #     redirect "/users/login"
  #   end
  # end
   
   def logout!
    session.clear
   end
  end

end

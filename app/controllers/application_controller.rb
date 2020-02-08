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
      #return true if user is logged in, otherwise false 
      !!current_user
      
    end
    
    def current_user 
      #should return current user, if there is one 
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

end

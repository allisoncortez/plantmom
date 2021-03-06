class UsersController < ApplicationController
  
  #users show page
  get '/users/show/:id' do 
    @user = User.find_by_id(session[:user_id])
    @plants = @user.plants
    erb :'/users/show'
  end
  
  
  
  get '/users/signup' do
    if !logged_in?
      erb :'users/signup'
    else 
      redirect "/users/show/#{current_user.id}"
    end
  end
  
  
  
  post '/users/signup' do 
    #create new user and persist to database
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      
      redirect '/users/signup'
    else 
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      if @user.save
        session[:user_id] = @user.id
        redirect "/users/show/#{current_user.id}"
      else
        # redirect '/users/signup'
        erb :'users/signup'
      end
    end
  end
  
  
  
  get '/users/login' do
    if !logged_in?
      erb :'/users/login'
    else 
      redirect "/users/show/#{current_user.id}"
    end
  end
  
  
  post '/users/login' do 
    login(params[:email], params[:password])
    redirect "/users/show/#{current_user.id}"
      
  end
  
  
  get '/logout' do 
    session.clear 
    redirect '/'
  end
  
end


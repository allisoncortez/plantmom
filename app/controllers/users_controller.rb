class UsersController < ApplicationController
  
  get '/login' do
    if logged_in?
      redirect '/plants'
    else 
      erb :'users/login'
    end
  end
  
  
  post '/login' do 
    
    #find user
    @user = User.find_by(email: params[:email])
    
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id #actually logs in the user
      
      redirect "/plants"
      
    else
      #flash[:message] = "Oops! Looks like your login failed. Please try again."
      erb :'/users/signup'
    end     
  end
    
    
  get '/users/signup' do
    erb :'/users/signup'
  end
  
  
  post '/users' do 
    #create new user and persist to database
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
    @user = User.create(params)
    session[:user_id] = @user.id
    
    #we're redirecting bc it's not our job to show this.. its /users/:id 
    redirect "/users/#{@user.id}"
    else
    end
  end
  
  
  #users show page
  get '/users/:id' do 
    @user = User.find_by(id: params[:id])
    erb :'/users/show'
  end
  
  
  get '/logout' do 
    session.clear 
    redirect '/'
  end
  
  
end


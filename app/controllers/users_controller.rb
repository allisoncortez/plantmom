class UsersController < ApplicationController
  
  #routes for login: renders login page/form
  get '/users/login' do
    erb :'/users/login'
  end
  
  
  post '/login' do 
    
    #find user
    @user = User.find_by(email: params[:email])
    
    #authenticate user 
    if @user && @user.authenticate(params[:password])
      
      #login user-create the user session
      session[:user_id] = @user.id #actually logs in the user
      
      #if true, redirect to users show page
      redirect "/users/show"
      
    else
      redirect '/users/signup'
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


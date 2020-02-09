class UsersController < ApplicationController
  
  #users show page
  get '/users/show/:id' do 
    @user = User.find_by_id(params[:id])
    erb :'/users/show'
  end
  
  get '/users/signup' do
    if !logged_in?
      erb :'users/signup'
    else 
      redirect '/users/show/:id'
    end
  end
  
  
  post '/signup' do 
    #create new user and persist to database
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/users/signup'
    else 
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
    
      #we're redirecting bc it's not our job to show this.. its /users/:id 
      redirect "/users/show/:id"
    end
  end
  
  get '/users/login' do
    if !logged_in?
      erb :'/users/login'
    else 
      redirect '/users/show/:id'
    end
  end
  
  
  post '/login' do 
    login(params[:email], params[:password])
    current_user 
    redirect '/users/show/:id'
      
    # else
    #   #flash[:message] = "Oops! Looks like your login failed. Please try again."
    #   erb :'/users/signup'
    # end     
  end
  
  
  get '/logout' do 
    session.clear 
    redirect '/'
  end
  
  
end


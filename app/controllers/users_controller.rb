class UsersController < ApplicationController
  
  #routes for login: renders login page/form
  get '/login' do
    erb :'/users/login'
  end
  
  post '/login' do 
    
    #find user
    @user = User.find_by(email: params[:email])
    
    #authenticate user 
    if @user.authenticate(params[:password])
      
      #login user-create the user session
      session[:user_id] = @user.id #actually logs in the user
      
      #if true, redirect to users show page
      redirect "/users/#{@user.id}"
      
    else
    #tell user they entered incorrect credentials 
    #redirect them to login
    end     
  end

    
    
  get '/users/signup' do
    erb :'/users/signup'
  end
  
  post '/users' do 
    #create new user and persist to database
    if params[:name] != "" && params[:email] != "" && params[:password] != ""
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






#   # GET: /users
#   get "/users" do
#     erb :"/users/index.html"
#   end

#   # GET: /users/new
#   get "/users/new" do
#     erb :"/users/new.html"
#   end

#   # POST: /users
#   post "/users" do
#     redirect "/users"
#   end

#   # GET: /users/5
#   get "/users/:id" do
#     erb :"/users/show.html"
#   end

#   # GET: /users/5/edit
#   get "/users/:id/edit" do
#     erb :"/users/edit.html"
#   end

#   # PATCH: /users/5
#   patch "/users/:id" do
#     redirect "/users/:id"
#   end

#   # DELETE: /users/5/delete
#   delete "/users/:id/delete" do
#     redirect "/users"
#   end

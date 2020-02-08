class UsersController < ApplicationController
  
  #routes for login: renders login page/form
  get '/login' do
    erb :login
  end
  
  post '/login' do 
    
    #find user
    @user = User.find_by(email: params[:email])
    
    #authenticate user 
    if @user.authenticate(params[:password])
      
      #login user-create the user session
      session[:user_id] = @user.id. #actually logs in the user
      
      #if true, redirect to users show page
      redirect "users/#{@user.id}"
      
    else
    #tell user they entered incorrect credentials 
    #redirect them to login
    end     
  end

    
    
  #signup: 
  get '/users/signup' do
    
  end
  
  #users show page
  get ‘/users/:id’ do 
    "user show route"
  
  end







  # GET: /users
  get "/users" do
    erb :"/users/index.html"
  end

  # GET: /users/new
  get "/users/new" do
    erb :"/users/new.html"
  end

  # POST: /users
  post "/users" do
    redirect "/users"
  end

  # GET: /users/5
  get "/users/:id" do
    erb :"/users/show.html"
  end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    erb :"/users/edit.html"
  end

  # PATCH: /users/5
  patch "/users/:id" do
    redirect "/users/:id"
  end

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
    redirect "/users"
  end
end

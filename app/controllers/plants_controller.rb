class PlantsController < ApplicationController

  #get plants new to creat new plant entries 
  get '/plants/new' do 
    if logged_in?
     erb :'plants/new'
    else
     redirect 'plants/login'
   end
  end

  #post route for new plant entries
  post '/plants' do 
  #create new plant and save to DB 
  #only if user is logged in 
    if !logged_in? 
      redirect '/'
    end 
  
    #only save IF it has all params
    if params[:description] != ""
      @plant_entry = Plant.create(name: params[:name], description: params[:description], care_level: params[:care_level],  user_id: current_user.id)
    
      redirect "/plants/#{@plant_entry.id}"
    else 
      redirect '/plants/new'
    end

  end


  #show route for plants
  get '/plants/:id' do 
    if logged_in?
      @plant_entry = Plant.find_by_id(params[:id])
      erb :'/plants/show'
    else
      redirect '/plants/login'
    end
  end

  #sends us to edit.erb which will render an edit form
  get '/plants/:id/edit' do 
    set_plant_entry
    if logged_in?
    if @plant_entry.user == current_user
      erb :'/plants/edit'
    else 
      redirect "users/#{current_user.id}"
    end
  else 
    redirect '/'
  end
  end
  
  patch '/plants/:id' do 
    #find plant entry 
    set_plant_entry
    if logged_in?
      if @plant_entry.user == current_user 
        
    #modify entry 
        @plant_entry.update(name: params[:name], description: params[:description], care_level: params[:care_level])
    
        redirect "/plants/#{@plant_entry.id}"
      else 
        redirect "users/#{current_user.id}"
  end
  
  private 
  
  def set_plant_entry 
    @plant_entry = Plant.find(params[:id])
  end
end

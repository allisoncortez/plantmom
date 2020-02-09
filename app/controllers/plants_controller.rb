class PlantsController < ApplicationController
  
  get '/plants' do 
    @plant_entries = Plant.all 
    erb :"plants/index"
  end
   
  get '/plants/new' do 
     erb :"plants/new"
  end
  
  #show route for plants
  get '/plants/:id' do 
    if logged_in?
      @plant_entry = Plant.find_by(id: params[:id])
      erb :'plants/show'
    else
      redirect '/plants/login'
    end
  end
  
  #sends us to edit.erb which will render an edit form
  get '/plants/:id/edit' do 
    @plant_entry = Plant.find_by(id: params[:id])
    if logged_in?
    if authorized_to_edit?(@plant_entry)
      erb :'/plants/edit'
    else 
      redirect "users/#{current_user.id}"
    end
  else 
    redirect '/'
  end
  end
  

  #post route for new plant entries
  post '/plants' do 
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

  
  patch '/plants/:id' do 
    @plant_entry = Plant.find(params[:id])
    if logged_in?
      if @plant_entry.user == current_user 
        
    #modify entry 
        @plant_entry.update(name: params[:name], description: params[:description], care_level: params[:care_level])
    
        redirect "/plants/#{@plant_entry.id}"
      else 
        redirect "users/#{current_user.id}"
      end
  end
  
  private 
  
    def set_plant_entry 
      @plant_entry = Plant.find(params[:id])
    end
end
end

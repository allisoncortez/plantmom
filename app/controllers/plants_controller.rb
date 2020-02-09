class PlantsController < ApplicationController
  
  get '/plants' do 
    @plant = Plant.all 
    erb :"/plants/index"
  end
   
  get '/plants/new' do 
     erb :"/plants/new"
  end
  
  #show route for plants
  get '/plants/:id' do 
      @plant = Plant.find_by(id: params[:id])
      erb :'/plants/show'
  end
  
  #sends us to edit.erb which will render an edit form
  get '/plants/:id/edit' do 
    @plant = Plant.find_by(id: params[:id])
      erb :'/plants/edit'
  end
  

  #post route for new plant entries
  post '/plants' do 
    @plant = Plant.new(params[:plant])
    if valid_params? && @plant.save 
      redirect "/plants/#{@plant.id}"
    else 
      redirect "/plants/new"
      
    # if !logged_in? 
    #   redirect '/'
    # end 
  
    # #only save IF it has all params
    # if params[:description] != ""
    #   @plant_entry = Plant.create(name: params[:name], description: params[:description], care_level: params[:care_level],  user_id: current_user.id)
    
    #   redirect "/plants/#{@plant_entry.id}"
    # else 
    #   redirect '/plants/new'
    end
  end

  
  patch '/plants/:id' do 
    @plant = Plant.find_by(id: params[:id])
    if valid_params? && @plant.update(params[:plant]) 
      redirect "/plants/#{@plant.id}"
    else
        redirect "/plants/#{@plant.id}/edit"
      end
  end
  
  delete '/plants/:id/delete' do 
    @plant = Plant.find_by(id: params[:id])
    @plant.delete 
    redirect "/plants"
  end
  
  helpers do
    def valid_params?
      params[:plant].none? do |k,v| 
        v == ""
      end
    end
  
    # def set_plant_entry 
    #   @plant_entry = Plant.find(params[:id])
    # end
end
end

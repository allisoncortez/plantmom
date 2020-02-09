class PlantsController < ApplicationController
  
  get '/plants' do 
    if logged_in?
    @plant = Plant.all 
    erb :"/plants/index"
    else
      redirect '/login'
    end
  end
   
  get '/plants/new' do 
    if logged_in?
     erb :"/plants/new"
   else
     redirect '/login'
   end
  end
  
  #post route for new plant entries
  post '/plants' do 
    if logged_in?
      if params[:name] == "" || params[:description] == "" || params[:care_level] == ""
        redirect "/plants/new"
      else 
        @plant = current_user.plants.build(name: params[:name], description: params[:description], care_level: params[:care_level])
        if @plant.save 
          redirect "/plants/#{@plant.id}"
        else 
          redirect "/plants/new"
        end 
      end
    else 
      redirect '/login'
    end
      
    
    # @plant = Plant.new(params[:plant])
    # if valid_params? && @plant.save 
    #   redirect "/plants/#{@plant.id}"
    # else 
    #   redirect "/plants/new"
    # end
  end
  
  #show route for plants
  get '/plants/:id' do 
    if logged_in?
      @plant = Plant.find_by_id(params[:id])
      erb :'/plants/show'
    else 
      redirect '/login'
    end
  end
  
  #sends us to edit.erb which will render an edit form
  get '/plants/:id/edit' do 
    if logged_in?
    @plant = Plant.find_by(id: params[:id])
      if @plant && @plant.user == current_user
        erb :'/plants/edit'
      else
        redirect '/login'
      end
  end

  
  patch '/plants/:id' do 
    @plant = Plant.find_by(id: params[:id])
    if valid_params? && @plant.update(params[:plant]) 
      redirect "/plants/#{@plant.id}/edit"
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

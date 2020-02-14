class PlantsController < ApplicationController
  
  get '/plants' do 
    if logged_in?
    @plant = Plant.all 
    erb :"/plants/index"
    else
      redirect '/users/login'
    end
  end
  
  
  get '/plants/new' do 
    if logged_in?
    erb :"/plants/new"
  else
    redirect '/users/login'
  end
  end
  
  
    #show route for plants
  get '/plants/:id' do 
    if logged_in?
      @plant = Plant.find_by(id: params[:id])
      erb :'/plants/show'
    else 
      redirect '/users/login'
    end
  end
  
  #sends us to edit.erb which will render an edit form
  get '/plants/:id/edit' do 
    @plant = Plant.find_by(id: params[:id])
    if logged_in? && current_user == @plant.user
        erb :'/plants/edit'
      else
        redirect '/plants'
    end
  end
  
  #post route for new plant entries
  post '/plants' do 
    if logged_in?
      if params[:name] == "" || params[:description] == "" || params[:care_level] == ""
        erb :'/plants/new'
      else 
        @plant = Plant.create(name: params[:name], description: params[:description], care_level: params[:care_level], user_id: current_user.id)
        if @plant.save
          redirect "/plants/#{@plant.id}"
        else 
          redirect "/plants/new"
        end 
      end
    else 
      redirect '/users/login'
    end
  end
      
    
    # @plant = Plant.new(params[:plant])
    # if valid_params? && @plant.save 
    #   redirect "/plants/#{@plant.id}"
    # else 
    #   redirect "/plants/new"
    # end
  
  

  
  patch '/plants/:id' do 
    if logged_in?
      if params[:name] == "" || params[:description] == "" || params[:care_level] == ""
        redirect "/plants/#{params[:id]}/edit"
      else
        @plant = Plant.find_by_id(params[:id])
        if @plant && @plant.user == current_user 
          if @plant.update(name: params[:name], description: params[:description], care_level: params[:care_level])
            redirect "/plants/#{params[:id]}"
          else
            redirect "/plants/#{params[:id]}/edit"
          end
        else
          redirect '/plants'
        end 
      end 
    else 
      redirect '/login'
    end
  end
  
  
  # attempt at refactoring code.. need to nest hash in a :plant key
  # patch '/plants/:id' do
  #   @plant = Plant.find_by_id(params[:id])
  #   if logged_in? && current_user == @plant.user
  #     if valid_params? && @plant.update(name: params[:name], description: params[:description], care_level: params[:care_level])
  #       redirect "/plants/#{params[:id]}"
  #     else 
  #       redirect "/plants/#{params[:id]}/edit"
  #     end 
  #   end
  # end
      
  
  delete '/plants/:id/delete' do 
    #plant user is current user:protection
     @plant = Plant.find_by(id: params[:id])
    if authorized_to_edit?(@plant)
    @plant.delete 
    redirect "/plants"
    else 
      redirect '/plants'
    end
  end
  
  
  # helpers do
  #   def valid_params?
  #     params[:plant].none? do |k,v| 
  #       v == ""
  #     end
  #   end
  # end
  
#my attempt below  
  #   def valid_params?
  #     if params[:name] != "" || params[:description] != "" || params[ :care_level] != ""
  #     else
  
  #     end
  #   end
  # end
    
    
end

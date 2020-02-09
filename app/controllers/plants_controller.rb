class PlantsController < ApplicationController

#get plants new to creat new plant entries 
get '/plants/new' do 
  erb :'/plants/new'
end

#post route for new plant entries
post '/plants' do 
#create new plant and save to DB 
#only if user is logged in 
  if !logged_in 
    redirect '/'
  end 
  
  #only save IF it has all params
  if params[:description] != ""
    @plant_entry = Plant.create(name: params[:name], description: params[:description], care_level: params[:care_level],  user_id: current_user.id)
    
    redirect "/plants/#{@plant.id}"
  else 
    redirect '/plants/new'
  end

end


#show route for plants

#index route for all plants

end

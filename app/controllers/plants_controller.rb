class PlantsController < ApplicationController

  # GET: /plants
  get "/plants" do
    erb :"/plants/index.html"
  end

  # GET: /plants/new
  get "/plants/new" do
    erb :"/plants/new.html"
  end

  # POST: /plants
  post "/plants" do
    redirect "/plants"
  end

  # GET: /plants/5
  get "/plants/:id" do
    erb :"/plants/show.html"
  end

  # GET: /plants/5/edit
  get "/plants/:id/edit" do
    erb :"/plants/edit.html"
  end

  # PATCH: /plants/5
  patch "/plants/:id" do
    redirect "/plants/:id"
  end

  # DELETE: /plants/5/delete
  delete "/plants/:id/delete" do
    redirect "/plants"
  end
end

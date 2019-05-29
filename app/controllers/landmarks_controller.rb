class LandmarksController < ApplicationController
  # add controller methods
  get '/landmarks' do
    @landmarks = Landmark.all
    
    erb :'landmarks/index'
  end
  
  get '/landmarks/new' do
    erb :'landmarks/new'
  end
  
  post '/landmarks' do
    @landmark = Landmark.create(params[:landmark])
    
    redirect to "/landmarks/#{@landmark.id}"
  end
  
  get '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    
    erb :'/landmarks/show'
  end
  
  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])
    
    erb :'/landmarks/edit'
  end
  
  patch '/landmarks/:id' do
    @landmark = Landmark.find_by_id(params[:id]) # find landmark
    @landmark.update(params[:landmark]) # update landmark
    
    redirect to "/landmarks/#{@landmark.id}" # redirect to landmarks/:id
  end
end

  patch '/figures/:id' do
    @figure = Figure.find_by_id(params[:id]) # find figure
    @figure.update(params[:figure]) # update figure
    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end
    
    if !params[:title][:name].empty?
      @figure.titles << Title.create(params[:title])
    end
    @figure.save
    
    redirect to "/figures/#{@figure.id}" # redirect to figure/:id
  end
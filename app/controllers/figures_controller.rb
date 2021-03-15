require 'pry'
class FiguresController < ApplicationController
  
  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find_by(id: params[:id])
    erb :'figures/show'
  end

  post '/figures' do
    #binding.pry
    @figure = Figure.create(params[:figure])
    @figure.titles << Title.create(name: params[:title][:name])
    @figure.landmarks << Landmark.create(params[:landmark])
    @figure.save
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by(id: params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/edit'
  end

  patch '/figures/:id' do
    #binding.pry
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])
    @figure.landmarks << Landmark.create(params[:landmark])
    redirect "/figures/#{@figure.id}"
  end

end

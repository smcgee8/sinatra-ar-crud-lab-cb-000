require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect '/posts'
  end

  #CREATE
  get '/posts/new' do
    erb :new
  end

  post '/posts' do
    post = Post.new(params)
    post.save
    redirect '/posts'
  end

  #READ
  get '/posts' do
    @posts = Post.all
    erb :index
  end

  get '/posts/:id' do
    @post = Post.find(params[:id])
    erb :show
  end

  #UPDATE
  get '/posts/:id/edit' do
    @post = Post.find(params[:id])
    erb :edit
  end

  patch '/posts/:id' do
    post = Post.find(params[:id])
    post.update(:name => params[:name], :content => params[:content])
    post.save
    redirect "/posts/#{post.id}"
  end

  #DESTROY
  delete '/posts/:id/delete' do
    @post = Post.find(params[:id])
    @post.destroy
    erb :delete
  end

end

require 'sinatra'
require 'sinatra/activerecord'
require './environments'

class Cut < ActiveRecord::Base
end

set :username,'Bond'
set :token,'shakenN0tstirr3d'
set :password,'007'

helpers do
  
  def admin? 
    request.cookies[settings.username] == settings.token 
  end
  
  def protected!
    halt [ 401, 'Not Authorized' ] unless admin?
  end
  
  include Rack::Utils
  alias_method :h, :escape_html
  
end

get "/" do
  @cut = Cut.all
  if !@cut.empty?
    erb :index
  else
    erb :new
  end
end

get "/cut_that/:id" do
  @id = params[:id]
  erb :cut, :layout => :base
end

get "/logged_in/new" do
  protected!
  erb :'logged_in/new', :layout => :'logged_in/logged_in'
end

get "/logged_in/list" do
  protected!
  @cut = Cut.all
  erb :'logged_in/list', :layout => :'logged_in/logged_in'
end

post "/logged_in/new" do
  @cut = Cut.create(:title => params[:title], :body => params[:body])
  redirect "/logged_in/list"
end

get "/logged_in/delete/:id" do
  protected!
  @cut = Cut.find(params[:id])
  erb :'logged_in/delete', :layout => :'logged_in/logged_in'
end

delete "/logged_in/delete/:id" do
  Cut.delete params[:id]
  redirect "/logged_in/list"
end

get "/logged_in/update/:id" do
  protected!
  @cut = Cut.find params[:id]
  erb :'logged_in/update', :layout => :'logged_in/logged_in'
end

patch "/logged_in/update/:id" do
  @cut = Cut.find params[:id]
  @cut.title = params[:title]
  @cut.body = params[:body]
  @cut.save
  redirect "/logged_in/list"
end

get "/admin" do
  unless admin?
    
    erb :'admin'
    #erb :menu, :layout => :logged_in
  else
    redirect "/logged_in/list" 
  end
end

post '/logged_in/login' do
  if params['username']==settings.username&&params['password']==settings.password
    response.set_cookie(settings.username,settings.token) 
    redirect '/logged_in/list'
  else
    "Username or Password incorrect"
  end
end

get "/logged_in/logout" do 
  response.set_cookie(settings.username, false)
  redirect '/' 
end
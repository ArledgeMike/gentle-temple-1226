require 'sinatra'
require 'sinatra/activerecord'
require './environments'


class Cut < ActiveRecord::Base

end


set :username,'Bond'
set :token,'shakenN0tstirr3d'
set :password,'007'

helpers do
  def admin? ; request.cookies[settings.username] == settings.token ; end
  def protected! ; halt [ 401, 'Not Authorized' ] unless admin? ; end
end

get "/" do
  @cut = Cut.all
  if !@cut.empty?
    erb :index
  else
    erb :new
  end
end

get "/new" do
  protected!
  erb :new
end

get "/cut_that/:id" do
  @id = params[:id]
  erb :cut, :layout => :base
end

get "/list" do
  protected!
  @cut = Cut.all
  erb :list
end

post "/new" do
  @cut = Cut.create(:title => params[:title], :body => params[:body])
  redirect "/"
end

get "/delete/:id" do
  protected!
  @cut = Cut.find(params[:id])
  erb :delete
end

delete "/delete/:id" do
  Cut.delete params[:id]
  redirect "/"
end

get "/update/:id" do
  protected!
  @cut = Cut.find params[:id]
  erb :update
end

patch "/update/:id" do
  @cut = Cut.find params[:id]
  @cut.title = params[:title]
  @cut.body = params[:body]
  @cut.save
  redirect "/"
end

get "/admin" do
erb :admin
end

post '/login' do
  if params['username']==settings.username&&params['password']==settings.password
    response.set_cookie(settings.username,settings.token) 
    redirect '/'
  else
    "Username or Password incorrect"
  end
end

get "/logout" do 
 response.set_cookie(settings.username, false)
 redirect '/' 
end

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end

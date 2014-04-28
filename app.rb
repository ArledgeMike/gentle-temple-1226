require 'sinatra'
require 'sinatra/activerecord'
require './environments'


class Cut < ActiveRecord::Base

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
erb :new
end

post "/new" do
  @cut = Cut.create(:title => params[:title], :body => params[:body])
  redirect "/"

end

delete "/delete/:id" do
 Cut.delete params[:id]
 redirect "/"
end

get "/update/:id" do
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

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end

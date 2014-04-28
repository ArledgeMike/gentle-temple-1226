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

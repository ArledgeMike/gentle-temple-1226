require 'sinatra'
require 'sinatra/activerecord'
require './environments'


class Cut < ActiveRecord::Base

end


get "/" do
  @posts = Cut.find(1).title
end
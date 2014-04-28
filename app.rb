require 'sinatra'
require 'sinatra/activerecord'
require './environments'


class Cut < ActiveRecord::Base

end


get "/" do
  "page one kid"
end
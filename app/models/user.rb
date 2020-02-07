class User < ActiveRecord::Base
  has_many :plants 
  
  
  validates_presence_of :username, :password 
end

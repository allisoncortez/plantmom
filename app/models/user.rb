class User < ActiveRecord::Base
  has_many :plants 
  has_secure_password
  
  validates_presence_of :username, :password 
end

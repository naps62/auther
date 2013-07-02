class User < ActiveRecord::Base
  include Auther::Model

  attr_accessible :email
end

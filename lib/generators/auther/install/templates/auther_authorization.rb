module Auther
  class Autherization < ActiveRecord::Base
    belongs_to :user
  end
end

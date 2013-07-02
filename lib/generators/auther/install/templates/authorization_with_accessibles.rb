class Authorization < ActiveRecord::Base
  belongs_to :user

  attr_accessible :provider,
                  :name,
                  :uid

end

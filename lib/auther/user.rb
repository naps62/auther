module Auther
  module User
    extend ActiveSupport::Concern

    include Clearance::User

    included do
      has_many :authorizations
    end
  end
end

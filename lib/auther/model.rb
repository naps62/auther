module Auther
  module Model
    extend ActiveSupport::Concern

    include Clearance::User

    included do
      has_many :authorizations

      def email_optional?
        authorizations.any?
      end
    end
  end
end

module Auther
  module Model
    extend ActiveSupport::Concern

    include Clearance::User

    included do
      has_many :autherizations

      def email_optional?
        autherizations.any?
      end
    end
  end
end

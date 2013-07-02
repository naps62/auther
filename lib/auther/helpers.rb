module Auther
  module Helpers
    extend ActiveSupport::Concern

    included do
      helper_method :autherize_path

      def autherize_path(provider)
        "/auth/#{provider.to_s.underscore}"
      end
    end

  end
end

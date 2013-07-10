module Auther
  module Helpers
    extend ActiveSupport::Concern

    included do
      helper_method :auther_oauth_path

      def auther_oauth_path(provider)
        "/auth/#{provider.to_s.underscore}"
      end
    end

  end
end

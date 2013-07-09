module Auther
  module Strategies
    class <%= strategy_name.underscore.camelize %> < Auther::Strategies::Base

      def omniauth
        Rails.application.config.middleware.use OmniAuth::Builder do
          provider :<%= strategy_name.underscore %>, Auther.accounts['<%= strategy_name.underscore %>']['app_id'], Auther.accounts['<%= strategy_name.underscore %>']['app_secret']
        end
      end

      def user
        { }
      end

      def autherization
        { }
      end

    end
  end
end

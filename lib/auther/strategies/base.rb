module Auther
  module Strategies
    class Base

      attr_reader :data

      def initialize(data)
        @data = data
      end

      def omniauth
        raise "Auther::Strategies::Base#omniauth should be overriden"
      end

      def user
        { }
      end

      def authorization
        { }
      end

      def full_user
        accessible_columns(::User, user)
      end

      def full_authorization
        accessible_columns(::Auther::Authorization, default_authorization.merge(authorization))
      end

      def default_authorization
        {
          provider: data.provider,
          uid:      data.uid,
          name:     data.info.name
        }.merge(authorization)
      end

      protected

      def accessible_columns(model, data)
        data.select do |attr,val|
          model.accessible_attributes.include? attr
        end
      end

    end
  end
end

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

      def autherization
        { }
      end

      def full_user
        accessible_columns(::User, user)
      end

      def full_autherization
        accessible_columns(::Autherization, default_autherization.merge(autherization))
      end

      def default_autherization
        {
          provider: data.provider,
          uid:      data.uid,
          name:     data.info.name
        }.merge(autherization)
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

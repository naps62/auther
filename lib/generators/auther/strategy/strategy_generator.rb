require 'rails/generators/base'
require 'rails/generators/active_record'

module Auther
  module Generators
    class StrategyGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      argument :strategy_name, type: :string

      def create_strategy
        template 'strategy.rb', File.join(Auther.config.strategies_root, "#{strategy_name.underscore}.rb")
      end

    end
  end
end

module Auther
  module Utils

    def self.strategy_name_to_class(name)
      name = name.to_s.camelize
      #if Auther::Strategies.const_defined?(name)
      begin
        require File.join(Auther.config.strategies_root, name.to_s.underscore)
        Auther::Strategies.const_get(name)
      #else
      rescue
        raise "undefined strategy Auther::Strategies::#{name}"
      end
    end

  end
end

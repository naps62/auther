module Auther
  class Configuration
    attr_accessor :accounts,
                  :accounts_file,
                  :exclude_providers,
                  :extra_providers,
                  :mailer_sender,
                  :strategies_root

    attr_reader :accounts, :providers, :strategies

    def initialize
      @accounts_file     = File.join('config', 'accounts.yml')
      @accounts          = []
      @exclude_providers = []
      @extra_providers   = []
      @mailer_sender     = 'reply@example.com'
      @strategies_root   = File.join(Rails.root, 'lib', 'auther', 'strategies')
    end

    def reload
      reload_omniauth
    end

    private

    def reload_omniauth
      @accounts = YAML.load_file(@accounts_file)['auther']
      @providers = (@accounts.keys + @extra_providers - @exclude_providers.map(&:to_s)).uniq
      @strategies = @providers.inject([]) do |strategies, provider|
        begin
          binding.pry
          strategies << Auther::Utils.strategy_name_to_class(provider).new(@accounts[provider])
        rescue Exception => e
          Rails.logger.info "Auther: strategy not found for provider #{provider}"
        end
          strategies
      end
      @strategies.map(&:omniauth)
    end
  end

  class << self
    attr_accessor :config
  end

  def self.configure(&block)
    self.config ||= Configuration.new
    yield config if block_given?
    self.config.reload
  end

  def self.accounts
    self.config.accounts
  end

  def self.providers
    self.config.providers
  end
end

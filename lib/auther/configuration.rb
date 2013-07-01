module Auther
  class Configuration
    attr_accessor :accounts_file,
                  :mailer_sender

    attr_reader :accounts

    def initialize
      @accounts_file   = File.join('config', 'accounts.yml')
      @mailer_sender   = 'reply@example.com'
    end

    def reload
      reload_omniauth
    end

    private

    def reload_omniauth
      @accounts = YAML.load_file(@accounts_file)
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
end

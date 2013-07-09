module Auther
  class OauthAuthenticator

    attr_reader :user

    def initialize(auth_data)
      set_info(auth_data)
    end

    def authenticate!
      find_by_autherization
      find_by_uid unless user
      create unless user
      return user
    end

    private

    attr_reader :autherization

    def find_by_autherization
      @autherization = Autherization.where(@auth_data.slice(:provider, :uid)).first
      @user = autherization.user if autherization
    end

    def find_by_uid
      autherization = Autherization.find_by_uid(@auth_data[:uid])
      user = autherization.user if autherization
      user.autherizations.create(@auth_data) if user
    end

    def create
      @user = User.new @user_data
      user.password = generate_password
      user.autherizations.build(@auth_data)
      user.save!
    end

    def set_info(data)
      strategy = Auther::Utils.strategy_name_to_class(data.provider).new(data)
      @auth_data = strategy.full_autherization
      @user_data = strategy.full_user
    end

    def generate_password
      SecureRandom.hex(20)
    end

  end
end

module Auther
  class OauthAuthenticator

    attr_reader :user

    def initialize(auth_data)
      set_info(auth_data)
    end

    def authenticate!
      find_by_authorization
      find_by_uid unless user
      create unless user
      return user
    end

    private

    attr_reader :authorization

    def find_by_authorization
      @authorization = Auther::Authorization.where(@auth_data.slice(:provider, :uid)).first
      @user = authorization.user if authorization
    end

    def find_by_uid
      authorization = Autherization.find_by_uid(@auth_data[:uid])
      user = authorization.user if autherization
      user.authorizations.create(@auth_data) if user
    end

    def create
      @user = User.new @user_data
      user.password = generate_password
      user.authorizations.build(@auth_data)
      user.save!
    end

    def set_info(data)
      strategy = Auther::Utils.strategy_name_to_class(data.provider).new(data)
      @auth_data = strategy.full_authorization
      @user_data = strategy.full_user
    end

    def generate_password
      SecureRandom.hex(20)
    end

  end
end

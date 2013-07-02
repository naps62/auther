module Auther
  class SessionsController < Clearance::SessionsController

    def create_from_omniauth
      authenticator = OauthAuthenticator.new(request.env['omniauth.auth'])
      @user = authenticator.authenticate!
      if @user.persisted?
        sign_in(@user)
        redirect_to root_url, notice: t('auther.flash.notice.sign_in')
      else
        redirect_to root_url, error: t('auther.flash.error.sign_in')
      end
    end

  end
end

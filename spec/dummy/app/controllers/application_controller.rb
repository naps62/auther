class ApplicationController < ActionController::Base
  include Auther::Controller
  protect_from_forgery

  def index
  end
end

class ApplicationController < ActionController::Base
  include Auther::Controller
  protect_from_forgery
end

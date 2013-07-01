module Auther
  module Controller
    extend ActiveSupport::Concern

    include Clearance::Controller
  end
end

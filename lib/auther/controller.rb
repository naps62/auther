module Auther
  module Controller
    extend ActiveSupport::Concern

    include Clearance::Controller
    include Auther::Helpers
  end
end

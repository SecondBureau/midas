module Refinery
  module Midas
    include ActiveSupport::Configurable

    config_accessor :devises

    self.devises = %w[cny eur usd]
  end
end
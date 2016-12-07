require "carb/service/version"

module Carb
  module Service
    def call(**args)
      raise NotImplementedError
    end
  end
end

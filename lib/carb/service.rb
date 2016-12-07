require "carb/service/version"
require "carb/service/curried"

module Carb
  module Service
    def call(**args)
      raise NotImplementedError
    end

    def curry(**args)
      Curried.new(self, args)
    end
  end
end

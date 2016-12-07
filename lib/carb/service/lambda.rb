require "carb/service"

module Carb::Service
  class Lambda
    include Carb::Service

    private

    attr_reader :block

    public

    def initialize(&block)
      @block = block
    end

    def call(**args)
      result = block.call(args)

    end
  end
end

require "carb/service"

module Carb::Service
  class Curried
    include Carb::Service

    private

    attr_reader :curried_args
    attr_reader :service

    public

    # TODO: Store is hash and curry everything properly
    def initialize(service, curried_args, is_hash)
      @service      = service
      @curried_args = curried_args
    end

    def call(**args)
      args = curried_args.merge(args)

      service.(args)
    end
  end
end

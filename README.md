# carb-service

Provides a strict interface to adhere to for service objects, offering curring
functionalities and possibility to wrap simple lambdas.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'carb-service'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install carb-service

## Usage

Just include `Carb::Service` in your class and strictly adhere to its interface

```ruby
require "carb-service"

class MyService
  include Carb::Service

  def call(result: nil)
    return Carb::Monads::Left(result) if result.nil?

    Carb::Monads::Right(result)
  end
end

service = MyService.new
service.()            # => Failure(nil)
service.(result: 123) # => Success(123)
```

You can also _curry_ the service (supply default values for `call` args):

```ruby
curried = service.curry(result: 123)
curried.()              # => Success(123)
curried.(result: "foo") # => Success("foo")
```

Notice that curried services are **full fledged services**.
You can also convert lambdas into services, the result will be automatically
wrapped in a `Success`

```ruby
service = Carb::Service::Lambda(->(**args) { 123 })
service.() # => Success(123)
```

A success matcher is provided to move forward when a monad is successful or
stop:

```ruby
require "carb/monads"
require "carb/monads/success_matcher"

result = nil
monad  = Carb::Monads::Right(123)

Carb::Monads::SuccessMatcher.(monad) do |match|
  match.success { |value| result = value }
  match.failure { |_| raise "Error" }
end

result # => 123
```

Check [dry-monads](http://dry-rb.org/gems/dry-monads/) and
[dry-matcher](http://dry-rb.org/gems/dry-matcher/) if you want to know more.


Finally, a set of helper utilities for testing have been provided for `rspec`:

```ruby
require "carb/rspec/service"
require "carb/rspec/monads"

describe "Yourtest" do
  include Carb::RSpec::Service
  include Carb::RSpec::Monads

  it "is a monad" do
    expect(Carb::Monads::Right(123)).to be_a_monad
  end

  it "is not a monad" do
    expect(123).not_to be_a_monad
  end

  it "is a success monad" do
    expect(Carb::Monads::Right(123)).to be_a_success_monad
  end

  it "is a failure monad" do
    expect(Carb::Monads::Left(123)).not_to be_a_success_monad
  end

  # Finally, a shared test to ensure the service adheres to the interface
  # The block requires a @service instance variable and a @success_call which is
  # a lambda that holds a successful call to the @service#call method
  it_behaves_like "Carb::Service" do
    before do
      @service      = Carb::Service::Lambda(-> { 123 })
      @success_call = -> { @service.() }
    end
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Carburetor/carb-service.


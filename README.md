# RunLater

Run any instance_method of ActiveRecord models via a job by adding `_later` to it.

## Installation

Add to your Gemfile

    $ bundle add run_later

Or install it yourself as:

    $ gem install run_later

## Usage

1. Include the `RunLater::Concern` in your model
2. Call instance methods with `_later`

```rb
class User < ApplicationRecord
  include RunLater::Concern

  after_create_commit :notify_user_later
  after_commit :refresh_cache_later

  private

  def notify_user
    # External services
    Sms.send(to: user.phone, message: 'Hey!')
  end

  def refresh_cache!
    # Expensive calculation
  end
end
```

To set the queue to any other than the `default` set it like this:

```rb
class User < ApplicationRecord
  include RunLater::Concern

  run_in_queue :low
end
```

If you need callbacks, they are provided as standart model callbacks:

```rb
class User < ApplicationRecord
  include RunLater::Concern

  before_run_later :do_something
  after_run_later :do_something_more
  around_run_later :do_something_around
  # Etc..
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kieranklaassen/run_later. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/kieranklaassen/run_later/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RunLater project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/kieranklaassen/run_later/blob/master/CODE_OF_CONDUCT.md).

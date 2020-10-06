# Database Cleaner Adapter for Nobrainer

[![Build Status](https://travis-ci.com/zedtux/database_cleaner-nobrainer.svg?branch=master)](https://travis-ci.com/zedtux/database_cleaner-nobrainer)

Clean your Nobrainer databases with Database Cleaner.

See https://github.com/DatabaseCleaner/database_cleaner for more information.

## Installation

```ruby
# Gemfile
group :test do
  gem 'database_cleaner-nobrainer'
end
```

## Supported Strategies

The nobrainer adapter only has one strategy: the deletion strategy.

## Strategy configuration options

`:only` and `:except` may take a list of collection names:

```ruby
# Only delete the "users" collection.
DatabaseCleaner[:nobrainer].strategy = :deletion, { only: ["users"] }

# Delete all collections except the "users" collection.
DatabaseCleaner[:nobrainer].strategy = :deletion, { except: ["users"] }
```

## Adapter configuration options

`#db` defaults to the Nobrainer database, but can be specified manually in a few ways:

```ruby
# Redis URI string:
DatabaseCleaner[:nobrainer].db = :logs

# Back to default:
DatabaseCleaner[:nobrainer].db = NoBrainer.current_db

# Multiple Nobrainer databases can be specified:
DatabaseCleaner[:nobrainer, connection: :default]
DatabaseCleaner[:nobrainer, connection: :shard_1]
DatabaseCleaner[:nobrainer, connection: :shard_2]
```

## Earthfile

The `Earthfile` is to be used with [Earthly](https://www.earthly.dev).

To build the development Docker image, simply run `earth +dev`.
To run the tests, run `earth -P +rspec`
To publish a new version of the gem, run `earth --build-arg RUBYGEMS_ORG_API_KEY=$(cat ~/.gem/credentials | grep :rubygems_api_key | awk '{print $2}') +publish`

Please look at [the Earthly documentation](https://docs.earthly.dev) for more.

## COPYRIGHT

See [LICENSE](LICENSE) for details.

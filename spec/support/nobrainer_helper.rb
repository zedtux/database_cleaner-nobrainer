# frozen_string_literal: true

require 'nobrainer'

# Runs the `NoBrainer.configure` so that it assigns the default values and
# passing the `app_name` used in building the database name.
# See http://nobrainer.io/docs/installation/#configuring-nobrainer-manually
NoBrainer.configure do |config|
  # app_name is the name of your application in lowercase.
  # When using Rails, the application name is automatically inferred.
  config.app_name = 'rspec'

  # environment defaults to Rails.env for Rails apps or to the environment
  # variables RUBY_ENV, RAILS_ENV, RACK_ENV, or :production.
  config.environment = 'test'
end

class User
  include NoBrainer::Document
end

class Agent
  include NoBrainer::Document
end

RSpec.configure do |config|
  config.before do
    User.delete_all
    Agent.delete_all
  end
end

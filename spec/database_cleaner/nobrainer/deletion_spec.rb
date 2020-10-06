# frozen_string_literal: true

require 'support/nobrainer_helper'
require 'database_cleaner/nobrainer/deletion'

RSpec.describe DatabaseCleaner::Nobrainer::Deletion do
  subject(:strategy) { described_class.new }

  describe '#clean' do
    context 'with records' do
      before do
        2.times { User.create! }
        2.times { Agent.create! }
      end

      it 'should delete all collections' do
        expect { strategy.clean }
          .to change { [User.count, Agent.count] }
          .from([2, 2])
          .to([0, 0])
      end

      it 'should only delete the collections specified in the :only option ' \
         'when provided' do
        expect { described_class.new(only: ['agents']).clean }
          .to change { [User.count, Agent.count] }
          .from([2, 2])
          .to([2, 0])
      end

      it 'should not delete the collections specified in the :except option' do
        expect { described_class.new(except: ['users']).clean }
          .to change { [User.count, Agent.count] }
          .from([2, 2])
          .to([2, 0])
      end

      it 'should raise an error when invalid options are provided' do
        expect { described_class.new(foo: 'bar') }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#db=' do
    def with_other_database(name)
      initial_db = NoBrainer.current_db.split('_')
      NoBrainer.configure do |config|
        # app_name is the name of your application in lowercase.
        # When using Rails, the application name is automatically inferred.
        config.app_name = name

        # environment defaults to Rails.env for Rails apps or to the environment
        # variables RUBY_ENV, RAILS_ENV, RACK_ENV, or :production.
        config.environment = 'test'
      end
      ret = yield
      # Calls once again the `NoBrainer.configure` with the previous `app_name`
      # which will force Nobrainer to manage to re-connect to the server with
      # the previous database name.
      NoBrainer.configure do |config|
        # app_name is the name of your application in lowercase.
        # When using Rails, the application name is automatically inferred.
        config.app_name = initial_db.first

        # environment defaults to Rails.env for Rails apps or to the environment
        # variables RUBY_ENV, RAILS_ENV, RACK_ENV, or :production.
        config.environment = initial_db.last
      end
      ret
    end

    it 'can accept a name to clean another database' do
      with_other_database :second do
        2.times { User.create! }
        2.times { Agent.create! }
      end

      strategy.db = :second_test

      expect { strategy.clean }
        .to change {
          with_other_database :second do
            [User.count, Agent.count]
          end
        }
        .from([2, 2])
        .to([0, 0])
    end
  end
end


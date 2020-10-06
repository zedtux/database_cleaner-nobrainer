# frozen_string_literal: true

require 'database_cleaner/nobrainer'
require 'database_cleaner/spec'

RSpec.describe DatabaseCleaner::Nobrainer do
  it_should_behave_like 'a database_cleaner adapter'
end

# frozen_string_literal: true

require 'database_cleaner/nobrainer/version'
require 'database_cleaner/core'
require 'database_cleaner/nobrainer/deletion'

DatabaseCleaner[:nobrainer].strategy = :deletion

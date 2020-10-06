# frozen_string_literal: true

require 'database_cleaner/strategy'

module DatabaseCleaner
  module Nobrainer
    class Deletion < Strategy
      def initialize(only: [], except: [])
        @only = only
        @except = except
      end

      def clean
        collections_to_delete.each do |table_name|
          NoBrainer.run do |r|
            if db == :default
              r.table(table_name).delete
            else
              r.db(db).table(table_name).delete
            end
          end
        end
      end

      private

      def collections
        if db == :default
          NoBrainer.run(&:table_list)
        else
          NoBrainer.run { |r| r.db(db).table_list }
        end
      end

      def collections_to_delete
        only = @only.any? ? @only : collections
        only - @except
      end
    end
  end
end

module Budgets
  module Templates
    class Abstract

      def initialize(budget)
        @budget = budget
      end

      def create_structure
      end

      def create_example_data
      end

      def self.field(name, options = {})
        self.fields[name] = options.merge(:name => name)
      end

      def self.fields
        @fields ||= {}
      end

      def fields
        self.class.fields.each_with_object({}) do |(name, options), hash|
          field_hash = options.dup
          if field_hash[:account] = @budget.accounts.where(:setup_tag => field_hash[:account].to_s).first
            hash[name] = field_hash
          end
        end
      end

    end
  end
end

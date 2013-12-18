require "multi_json"

module Kajomi
  module Entities
    class User < Base
      attr_accessor :uid, :email, :firstname, :lastname

      def initialize(attrs={})
        attrs.each do |key, value|
          self.send(:"#{key}=", value)
        end
      end

      def to_array
        [@email, @firstname, @lastname]
      end
    end
  end
end

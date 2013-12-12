module Kajomi
  module Entities
    class Base
      def to_json
        raise "Not implemented"
      end
    end
  end
end

require "kajomi/entities/list"
